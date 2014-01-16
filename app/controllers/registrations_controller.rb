require 'json'

class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :show]

  # GET /registrations
  # GET /registrations.json
  def index
    # render :text => "test"
    @list_options = load_list_options
    @previously_selected_workshop = params["workshop"]
    @previously_selected_type = params["form_type"]
    workshop = nil
    registrations_data_participant = []
    registrations_data_coach = []

    if (!params["workshop"])
      workshop = Workshop.find_by_status("published")
    else
      if params["workshop"] != "all"
        workshop = Workshop.find(params["workshop"])
      end
    end
    if params["workshop"] != "all"
      if (workshop.participant_form? && params["form_type"] != "coach")
        registrations_data_participant = workshop.participant_form.registrations
      end
      if (workshop.coach_form? && params["form_type"] != "participant" )
        registrations_data_coach = workshop.coach_form.registrations
      end
    end

    @participant_registrations = []
    @participant_structure = nil
    @coach_registrations = []
    @coach_structure = nil

    if workshop
      if registrations_data_participant.count > 0
          tmp = parse_structure(workshop.participant_form, registrations_data_participant)
          @participant_registrations = tmp[0]
          @participant_structure = tmp[1]
      end
      if registrations_data_coach.count > 0
          tmp = parse_structure(workshop.coach_form, registrations_data_coach)
          @coach_registrations = tmp[0]
          @coach_structure = tmp[1]
      end
    elsif params["workshop"]
      @participant_structure = [{"type"=>"text", "caption"=>"Firstname", "name"=>"firstname", "class"=>"immutable_element", "id"=>"0"},
        {"type"=>"text", "caption"=>"Lastname", "name"=>"lastname", "class"=>"immutable_element", "id"=>"1"},
        {"type"=>"text", "caption"=>"E-Mail", "name"=>"email", "class"=>"immutable_element", "id"=>"2"}]
      if params["form_type"] == "all"
        Registration.all.each do |registration|
          reg = {"id"=>registration.id, "attributes"=>
            {"firstname"=>registration.attributes["firstname"],
            "lastname"=>registration.attributes["lastname"],
            "email"=>registration.attributes["email"]}}
            @participant_registrations.push(reg)
        end
      elsif params["form_type"] == "participant"
        Registration.find_all_by_form_type("ParticipantForm").each do |registration|
          reg = {"id"=>registration.id, "attributes"=>
            {"firstname"=>registration.attributes["firstname"],
            "lastname"=>registration.attributes["lastname"],
            "email"=>registration.attributes["email"]}}
            @participant_registrations.push(reg)
        end
      else
        Registration.find_all_by_form_type("CoachForm").each do |registration|
          reg = {"id"=>registration.id, "attributes"=>
            {"firstname"=>registration.attributes["firstname"],
            "lastname"=>registration.attributes["lastname"],
            "email"=>registration.attributes["email"]}}
            @participant_registrations.push(reg)
        end
      end
    end
  end

  def parse_structure(form, registrations_data)
    registrations = []
    structure = JSON.parse form.structure
    hidden_keys = ["_id", "form_id", "form_type", "authenticity_token", "form_type", "action", "controller"]
    registrations_data.each do |registration|
      attributes = registration.attributes.clone
      hidden_keys.each do |key|
        attributes.delete key
      end
      i = 0
      for elem in structure
        if elem["type"] == "radiobuttons"
          val = attributes[elem["name"]]
          attributes[elem["name"]] = elem["options"][val]
        end
        i += 1
      end

      reg = {}
      reg["id"] = registration.id.to_s
      reg["attributes"] = attributes
      registrations.push reg
    end
    structure_and_registration = [registrations, structure]
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
        RegistrationMailer.welcome_email(@registration, mail_text).deliver
        flash[:success] = "Your registration was successful"
        redirect_to success_reg_path
      else
        flash[:error] = "Your registration was not successfull"
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

    def load_list_options
      workshop_options = []
      workshop_options.push(["all", "all"])
      Workshop.all.each do |workshop|
        workshop_options.push([workshop.name + " : " + workshop.date.to_s, Workshop.find(workshop.id).id])
      end
      options = {:workshop => workshop_options, :form_type => ["all", "participant", "coach"]}
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
