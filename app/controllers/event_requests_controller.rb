class EventRequestsController < ApplicationController
  before_action :set_event_request, only: [:show, :edit, :update, :destroy]

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

    if @event_request.save
      redirect_to @event_request, notice: 'Event request was successfully created.'
    else
      render :new
    end
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
    redirect_to event_requests_url, notice: 'Event request was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_request
      @event_request = EventRequest.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_request_params
      params.fetch(:event_request, {})
    end
end
