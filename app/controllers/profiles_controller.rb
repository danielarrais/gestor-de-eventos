class ProfilesController < ApplicationController
  load_and_authorize_resource

  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_permissions_for_select, only: [:edit, :new, :update]
  before_action :set_filter_object, only: [:index]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = FindProfile.find(@filter, page_params)
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, success:'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, success:'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, success:'Profile was successfully destroyed.' }
      format.json { head :no_content }
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

  # Use callbacks to share common setup or constraints between permissions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  def set_permissions_for_select
    @permissions = Permission.all.select(:name, :id).map { |k, v| [k.name, k.id] }
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def profile_params
    params.require(:profile).permit(:name, :description, :custom, permission_ids: [])
  end
end
