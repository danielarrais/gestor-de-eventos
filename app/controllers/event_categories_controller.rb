class EventCategoriesController < ApplicationController

  load_and_authorize_resource
  before_action :set_event_category, only: [:show, :edit, :update, :destroy]
  before_action :set_filter_object, only: [:index]

  # GET /event_categories
  # GET /event_categories.json
  def index
    @event_categories = FindEventCategory.find(@filter, page_params)
  end

  # GET /event_categories/1
  # GET /event_categories/1.json
  def show
  end

  # GET /event_categories/new
  def new
    @event_category = EventCategory.new
  end

  # GET /event_categories/1/edit
  def edit
  end

  # POST /event_categories
  # POST /event_categories.json
  def create
    @event_category = EventCategory.new(event_category_params)

    respond_to do |format|
      if @event_category.save
        format.html { redirect_to @event_category, success: 'Event category was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /event_categories/1
  # PATCH/PUT /event_categories/1.json
  def update
    respond_to do |format|
      if @event_category.update(event_category_params)
        format.html { redirect_to @event_category, success: 'Event category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /event_categories/1
  # DELETE /event_categories/1.json
  def destroy
    @event_category.destroy
    respond_to do |format|
      format.html { redirect_to event_categories_url, success: 'Event category was successfully destroyed.' }
    end
  end

  private

  def set_filter_object
    @params = params[:filter] || {}
    @filter = Filter.new({
                             name: @params[:name],
                             description: @params[:description]
                         })
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_event_category
    @event_category = EventCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_category_params
    return unless params[:event_category].present?
    params.require(:event_category).permit(:name, :description)
  end
end
