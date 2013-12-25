class FormsController < ApplicationController
  before_action :set_form, only: [:show, :edit, :update, :destroy]

  # GET /forms
  def index
    @forms = Form.all
  end

  # GET /forms/1
  def show
  end

  # GET /forms/new
  def new
    @form = Form.new    
  end

  # GET /forms/1/edit
  def edit
  end

  # POST /forms
  def create
    # render :text=>form_params[:template]
    workshop_id = form_params[:workshop_id]
    workshop_id['/'] = ''
    workshop = Workshop.find(:id => workshop_id)
    print workshop

    if form_params[:type] == "coach/"
      @form = CoachForm.new(form_params)
    else
      @form = ParticipantForm.new(form_params)
    end
    if @form.save
      redirect_to @form, notice: 'Form was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /forms/1
  def update

  end

  # DELETE /forms/1
  def destroy
    @form.destroy
    if @form.workshop != nil
      @form.workshop.status = nil
      @form.workshop.save
    end
    redirect_to forms_url, notice: 'Form was successfully destroyed. Due to this, the corresponding Workshop is no longer published'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_form
      @form = Form.find(params[:id])
      logger.debug "id: #{params[:id]}"
    end

    # Only allow a trusted parameter "white list" through.
    def form_params
      params[:form]
    end
end
