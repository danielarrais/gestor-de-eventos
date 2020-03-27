class PermissionsController < ApplicationController
  before_action :set_action, only: [:show, :edit, :update]

  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all.page(params[:page]).per(10)
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
      notice = "Novas permissões foram encontradas e cadastradas."
    else
      notice = "Nenhuma permissão nova foi encontrada."
    end

    respond_to do |format|
      format.html { redirect_to permissions_path, notice: notice }
    end
  end

  # PATCH/PUT /permissions/1
  # PATCH/PUT /permissions/1.json
  def update
    respond_to do |format|
      if @permission.update(permission_params)
        format.html { redirect_to @permission, notice: 'Action was successfully updated.' }
        format.json { render :show, status: :ok, location: @permission }
      else
        format.html { render :edit }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between permissions.
  def set_action
    @permission = Permission.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def permission_params
    params.require(:permission).permit(:name, :description)
  end
end
