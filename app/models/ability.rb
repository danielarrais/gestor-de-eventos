class Ability
  include CanCan::Ability

  def initialize(user)
    all_permissions = Permission.all.where(public: true).to_a
    all_permissions += user.all_permissions if user.all_permissions.any?

    all_permissions.each do |permission|
      can_actions(permission.controller_key.to_sym, [permission.action_key])
      can_actions(permission.controller_key.to_sym, permission.equivalent_actions)
    end
  end

  private

  def can_actions(controller_name, actions)
    return if actions.nil?

    model_name = model_name(controller_name.to_s.camelcase)
    independent_control = Object.const_defined?(model_name)
    can_name = independent_control ? Object.const_get(model_name) : controller_name.to_sym

    actions.each do |action|
      can action.to_sym, can_name
    end
  end

  def model_name(controller_name)
    Object.const_get(controller_name).controller_name.classify
  end
end
