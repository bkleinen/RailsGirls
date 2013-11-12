class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]

  # GET /registrations
  # GET /registrations.json
  def index
    if(index_params['type'] == 'coach')
      @registrations = CoachRegistration.all
    elsif(index_params['type'] == 'participant')
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

  # GET /registrations/1/edit
  def edit
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = ParticipantRegistration.new(registration_params)
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
    respond_to do |format|
      if @registration.update(registration_params)
        flash[:success] = "The update was successful"
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = ParticipantRegistration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:firstname, :lastname, :email, :twitter, :programming, :railsexperience, :motivation, :os, :specialdiet)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def index_params
      params.permit(:type)
    end
end
