class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :release_issuing_certificates]
  before_action :set_list_for_select, only: [:index, :new, :edit, :update, :create]
  before_action :verify_action, only: [:edit, :update, :destroy]

  # GET /events
  def index
    @event = Event.new(event_params)
    @events = FindEvent.find(event_params, page_params)
  end

  # GET /events/1
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # GET /events/1/edit
  def release_issuing_certificates
    if @event.frequence.present? && @event.frequence.participants.any?
      @event.current_user = current_user
      @event.release_issuing_certificates
      flash[:success] = "Emissão de certificado liberada com sucesso"
    else
      @event.errors.add(:base, "Preeencha a frequencia antes de liberar a emissão de certificados")
    end
  end

  # POST /events
  def create
    @event = Event.new(event_params)
    @event.current_user = current_user

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, success: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  def update
    @event.current_user = current_user
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, success: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, success: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def verify_action
    redirect_to events_url, warning: 'A solicitação não pode ser alterada após o envio' if @event.draft?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_list_for_select
    @event_categories = EventCategory.select(:name, :id).map { |k, v| [k.name, k.id] }
    @courses = Course.select(:name, :id).map { |k, v| [k.name, k.id] }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :start_date, :closing_date, :event_category_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    return unless params[:event].present?
    params.require(:event).permit(:name,
                                  :start_date,
                                  :closing_date,
                                  :event_category_id,
                                  :workload,
                                  image_attributes: [:id, :file],
                                  oriented_activities_attributes: [:id,
                                                                   :event_category_id,
                                                                   :title,
                                                                   :_destroy,
                                                                   person_ids: [],
                                                                   guideds_attributes: [:id,
                                                                                        :person_id,
                                                                                        :course_id,
                                                                                        :_destroy,
                                                                                        :semester],],
                                  child_events_attributes: [:id,
                                                            :_destroy,
                                                            :name,
                                                            :start_date,
                                                            :closing_date,
                                                            :event_category_id,
                                                            :workload],
                                  people_attributes: [:id, :_destroy])
  end
end
