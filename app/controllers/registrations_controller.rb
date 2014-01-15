require 'json'

class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :show]

  # GET /registrations
  # GET /registrations.json
  def index
      registrations_data = Registration.all
      @registrations = []
      if registrations_data.count > 0
        @form = Form.find(registrations_data.first.form_id)
        if @form
          @structure = JSON.parse @form.structure
          hidden_keys = ["_id", "form_id", "form_type", "authenticity_token", "form_type", "action", "controller"]
          registrations_data.each do |registration|
            attributes = registration.attributes.clone
            hidden_keys.each do |key|
              attributes.delete key
            end
            i = 0
            for elem in @structure
              if elem["type"] == "radiobuttons"
                val = attributes[elem["name"]]
                attributes[elem["name"]] = elem["options"][val]
              end
              i += 1
            end
            reg = {}
            reg["id"] = registration.id.to_s
            reg["attributes"] = attributes
            @registrations.push reg
            print @structure
          end
        end
      end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @registration = Registration.new
    if params[:type] == 'participant'
      @form = Workshop.find(params[:id]).participant_form
    elsif params[:type] == Workshop.find(params[:id]).coachKey
      @form = Workshop.find(params[:id]).coach_form
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find_by_id(params[:id])
    @form = @registration.form
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params)
    print @registration
    @registration.form = Form.find(params[:form_id])
    print @registration.form
      if @registration.save
        # send email to participant after registration not working jet.
        workshop = @registration.form.workshop
        mail_text = workshop.mail_template.filter_text(@registration)
        print "-------------------call deliver_mail -----------------------"
        RegistrationMailer.deliver_welcome_email(@registration, mail_text)
        flash[:success] = "Your registration was successful"
        redirect_to success_reg_path
      else
        flash[:error] = "Your registration was not successful"
        redirect_to :back
      end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    @registration = Registration.find_by_id(params[:id])
    if @form.update_attributes(registration_params)
      redirect_to @registration, notice: 'Registration was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
    # params.require(:registration).permit(:firstname, :lastname, :email, :language, :last_attended, :coding_level, :os, :other_languages, :project, :idea, :want_learn, :group, :join_group, :notes)
      params
    end

    # Before filters
    def signed_in_user
      store_location
      redirect_to admin_path, notice: "Only for Admins available! Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
