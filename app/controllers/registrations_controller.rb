class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update]

  # GET /registrations
  # GET /registrations.json
  def index
    if(index_params[:type] == 'coach')
      @registrations = CoachRegistration.all
    else
      @registrations = ParticipantRegistration.all
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @registration = ParticipantRegistration.new
  end

  def new_coach
    @registration = CoachRegistration.new
  end

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(registration_params)
      if @registration.save
        flash[:success] = "Your registration was successful"
        redirect_to @registration
      else
        render 'new'
      end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    if @registration.update(registration_params)
      flash[:success] = "The update was successful"
      redirect_to @registration
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
      params.require(:registration).permit(:firstname, :lastname, :email, :language, :last_attended, :coding_level, :os, :other_languages, :project, :idea, :want_learn, :group, :join_group, :notes)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_params
      params.permit(:type)
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
