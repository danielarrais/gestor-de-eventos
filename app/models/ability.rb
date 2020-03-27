class Ability
  include CanCan::Ability

  def initialize(user)
    all_permissions = Permission.all.where(public: true).to_a
    all_permissions += user.all_permissions if user.all_permissions.any?

    all_permissions.each do |x|
      independent_control = Object.const_defined?(x.controller)
      can x.action.to_sym, independent_control ? Object.const_get(x.controller) : x.controller.underscore.to_sym
    end
  end
end
