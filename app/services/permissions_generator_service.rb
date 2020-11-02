require 'liquid'

class PermissionsGeneratorService
  private_class_method :new

  def self.call(controllers)
    self.new.send(:generate_from_controllers_name, controllers)
  end

  private

  def generate_from_controllers_name(controllers)
    controllers.each do |controller|
      controller_class = Object.const_get(controller.to_s)
      action_methods = Object.const_get(controller_class.name).action_methods

      controller_key = controller_class.name.underscore
      controller_name = Translate.translate_permission_controller(controller_key)

      action_methods.each do |action|
        saved_action = Permission.find_by(action_key: action, controller_key: controller_key)
        action_name = Translate.translate_permission_action(controller_key, action)

        next if action_name.nil?

        permission_properties = { action: action_name,
                                  action_key: action,
                                  controller: controller_name,
                                  controller_key: controller_key,
                                  equivalent_actions: equivalent_actions[action.to_sym] }


        saved_action.update(permission_properties) if saved_action.present?
        Permission.create(permission_properties) unless saved_action.present?
      end
    end
  end

  def equivalent_actions
    { show: [:index],
      new: [:create],
      edit: [:update] }
  end
end
