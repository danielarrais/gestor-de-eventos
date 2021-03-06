class PermissionsController < ApplicationController

  load_and_authorize_resource
  before_action :set_action, only: [:show, :edit, :update]
  before_action :set_filter_object, only: [:index]

  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = FindPermission.find(@filter, page_params)
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
  end

  # GET /permissions/1/edit
  def edit
  end

  def recreate_and_update_all
    controllers = ApplicationController.subclasses

    if Permission::import_from_controllers(controllers)
      notice = "Base de permissões atualizadas com sucesso."
    else
      notice = "Falha ao atualizar base de permissões."
    end

    respond_to do |format|
      format.html { redirect_to permissions_path, success: notice }
    end
  end

  # PATCH/PUT /permissions/1
  # PATCH/PUT /permissions/1.json
  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to @permission, success: 'Action was successfully updated.' }
      else
        format.html { render :edit }
      end
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
  def set_action
    @permission = Permission.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permission_params
    params.require(:permission).permit(:name, :description)
  end
end
