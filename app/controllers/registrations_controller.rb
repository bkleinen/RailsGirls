class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :show]

  # GET /registrations
  # GET /registrations.json
  def index
      @registrations = Registration.all    
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @registration = Registration.new()
    @form = Workshop.find(params[:id]).participant_form
    # render :text => @form.structure
  end


  # GET /registrations/1/edit
  def edit
    @registration = Registration.find_by_id(params[:id])
    @form = Form.first
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(params)
    @registration.form = Form.find(params[:form_id])
      if @registration.save
        flash[:success] = "Your registration was successful"
        redirect_to success_reg_path
      else
        render 'new'
      end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    @registration = Registration.find_by_id(params[:id])
    logger.debug "registration: DEEEEEEEEEEBUG!!!_: #{Registration.find_by_id(params[:id])}"
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
