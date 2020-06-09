class EventRequestsController < ApplicationController
  before_action :set_event_request, only: [:show, :edit, :update, :destroy, :forward_the_request]
  before_action :set_list_for_select, only: [:new, :edit, :update, :create]

  # GET /event_requests
  def index
    @event_requests = EventRequest.all.page(params[:page]).per(10)
  end

  # GET /event_requests/1
  def show
  end

  # GET /event_requests/new
  def new
    @event_request = EventRequest.new
  end

  # GET /event_requests/1/edit
  def edit
  end

  # POST /event_requests
  def create
    @event_request = EventRequest.new(event_request_params)
    @event_request.person = current_user.person

    if @event_request.save
      redirect_to @event_request, notice: 'Event request was successfully created.'
    else
      render :new
    end
  end

  # GET /event_requests/1
  def forward_the_request
    @event_request.forward
    redirect_to event_requests_url, notice: 'Solicitação de Evento encaminhada com sucesso'
  end

  # PATCH/PUT /event_requests/1
  def update
    if @event_request.update(event_request_params)
      redirect_to @event_request, notice: 'Event request was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /event_requests/1
  def destroy
    @event_request.destroy
    redirect_to event_requests_url, notice: 'Solicitação de Evento excluída com sucesso'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_list_for_select
    @event_categories = EventCategory.select(:name, :id).map { |k, v| [k.name, k.id] }
    @courses = Course.select(:name, :id).map { |k, v| [k.name, k.id] }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event_request
    @event_request = EventRequest.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def event_request_params
    params.require(:event_request).permit(:additional_information,
                                          event_attributes: [:id, :name, :start_date, :closing_date, :event_category_id,
                                                             :workload, image_attributes: [:id, :file],
                                                             oriented_activities_attributes: [:id, :event_category_id, :title,
                                                                                              :_destroy, person_ids: [],
                                                                                              guideds_attributes: [:id, :person_id,
                                                                                                                   :course_id, :_destroy,
                                                                                                                   :semester],],
                                                             child_events_attributes: [:id, :_destroy, :name, :start_date, :closing_date,
                                                                                       :event_category_id, :own_certificate, :workload],
                                                             people_attributes: [:id, :_destroy]])
  end
end
