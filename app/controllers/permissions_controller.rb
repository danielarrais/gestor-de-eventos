Dir["#{Rails.root}/app/controllers/*.rb"].each { |file| require_dependency file }

class PermissionsController < ApplicationController
  before_action :set_action, only: [:show, :edit, :update]

  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all
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
    count_permissions_created = 0

    controllers.each do |controller|
      puts "Controller #{controller}"
      controller_class = Object.const_get(controller.to_s)
      action_methods_name = Object.const_get(controller_class.name).action_methods

      action_methods_name.each do |action|
        controller_formated_name = controller_class.name.underscore

        saved_action = Permission.where(action: action, controller: controller_formated_name).first

        if saved_action.present?
          puts "Action #{action} already exists"
        else
          Permission.new(name: "#{controller_class.name}##{action}",
                     description: "#{controller_class.name}##{action}",
                     controller: controller_class.name.underscore,
                     action: action).save
          count_permissions_created += 1
        end
      end
    end

    respond_to do |format|
      notice = "Lista atualizada com sucesso, #{count_permissions_created} novas permissões encontradas e cadastradas."
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
