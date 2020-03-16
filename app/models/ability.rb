class Ability
  include CanCan::Ability

  def initialize(user)
    all_actions = Action.all.where(public: true).to_a
    all_actions += user.all_actions if user.all_actions.any?

    all_actions.each do |x|
      independent_control = Object.const_defined?(x.controller)
      can x.action.to_sym, independent_control ? Object.const_get(x.controller) : x.controller.underscore.to_sym
    end
  end
end
