require 'active_support'

class WorkshopsController < ApplicationController

  before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user, only: [:index, :edit, :update, :show]
  # GET /workshops
  def index
    @workshops = Workshop.all
    @forms = Form.all
    @mail_templates = MailTemplate.all
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

  def add_mail_template
    @existing_mail_template = MailTemplate.find(params[:id])
    @workshop = Workshop.find(params[:workshop_id])
    @mail_template = MailTemplate.new
    @mail_template.workshop_id = params[:workshop_id]
    @mail_template.name = @existing_mail_template.name
    @mail_template.subject = @existing_mail_template.subject
    @mail_template.text = @existing_mail_template.text

    if @mail_template.save
      redirect_to workshops_url, notice: 'Workshop was successfully updated.'
    else
      redirect_to workshops_url, notice: 'Could not update Workshop.'
    end
  end

  def manual_mail_show

  end

  def manual_mail_send
    RegistrationMailer.manual_email(params).deliver
    redirect_to workshops_url, notice: 'E-Mail was successfully sent.'
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
    standard_mail_template = MailTemplate.create(:workshop_id => @workshop.id)
    if @workshop.save
      redirect_to workshops_path, notice: 'Workshop was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /workshops/1
  def update
    if @workshop.update_attributes(workshop_params)
      redirect_to workshops_url, notice: 'Workshop was successfully updated.'
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
