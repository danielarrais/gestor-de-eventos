class Ability
  include CanCan::Ability

  def initialize(user)
    all_permissions = Permission.all.where(public: true).to_a
    all_permissions += user.all_permissions if user.all_permissions.any?

    all_permissions.each do |x|
      controller_name = x.controller.camelcase
      model_name = model_name_for_controller(controller_name)
      independent_control = Object.const_defined?(model_name)
      can x.action.to_sym, independent_control ? Object.const_get(model_name) : x.controller.to_sym
    end
  end

  def model_name_for_controller(controller)
    Object.const_get(controller).controller_name.classify
  end
end
