require 'active_support'

class WorkshopsController < ApplicationController

  before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :show]
  # GET /workshops
  def index
    @workshops = Workshop.all
    @forms = Form.all
  end

  def publish
    @workshop = Workshop.find(params[:id])
    if (@workshop.participant_form != nil)
      @workshop.update_attributes(:status => "published")
      @workshop.save
      redirect_to workshops_url, notice: 'Workshop was successfully updated.'
    else
      redirect_to workshops_url, notice: 'Workshop could not be published. Please create a participant form!'
    end
  end

  def addForm
    @existing_form = Form.find(params[:id])
    @workshop = Workshop.find(params[:workshop_id])
    #just temporary better way would be to do a redirect to create in the forms controller or sending the data via rubies Net::HTTP
    if params[:type] == "coach"
      @form = CoachForm.new
      @key = SecureRandom.hex 
      @workshop.update_attributes(:coachKey => @key)
      @workshop.save  
    else
      @form = ParticipantForm.new
    end
    @form.workshop_id = params[:workshop_id]
    @form.structure = @existing_form.structure
    if @form.save
      redirect_to workshops_url, notice: 'Workshop was successfully updated.'
    else
      redirect_to workshops_url, notice: 'Could not update Workshop.'
    end
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
  end

  # GET /workshops/1/edit
  def edit
  end

  # POST /workshops
  def create
    @workshop = Workshop.new(workshop_params)    
    if @workshop.save
      redirect_to workshops_path, notice: 'Workshop was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /workshops/1
  def update
    if @workshop.update_attributes(workshop_params)
      redirect_to @workshop, notice: 'Workshop was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /workshops/1
  def destroy
    @workshop.destroy
    redirect_to workshops_url, notice: 'Workshop was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
    end

    # Before filters
    def signed_in_user
      store_location
      redirect_to admin_path, notice: "Only for Admins available! Please sign in." unless signed_in?
    end

    # Only allow a trusted parameter "white list" through.
    def workshop_params
      params.require(:workshop).permit(:name, :date, :description, :venue)
    end
end
