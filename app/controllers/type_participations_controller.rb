class TypeParticipationsController < ApplicationController

  load_and_authorize_resource
  before_action :set_type_participation, only: [:show, :edit, :update, :destroy]
  before_action :set_filter_object, only: [:index]

  # GET /type_participations
  def index
    @type_participations = FindTypeParticipation.find(@filter, page_params)
  end

  # GET /type_participations/1
  def show
  end

  # GET /type_participations/new
  def new
    @type_participation = TypeParticipation.new
  end

  # GET /type_participations/1/edit
  def edit
  end

  # POST /type_participations
  def create
    @type_participation = TypeParticipation.new(type_participation_params)

    if @type_participation.save
      redirect_to @type_participation, success: 'Type participation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /type_participations/1
  def update
    if @type_participation.update(type_participation_params)
      redirect_to @type_participation, success: 'Type participation was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /type_participations/1
  def destroy
    @type_participation.destroy
    redirect_to type_participations_url, success: 'Type participation was successfully destroyed.'
  end

  private

  def set_filter_object
    @params = params[:filter] || {}
    @filter = Filter.new({
                             name: @params[:name]
                         })
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_type_participation
    @type_participation = TypeParticipation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def type_participation_params
    params.require(:type_participation).permit(:name)
  end
end
