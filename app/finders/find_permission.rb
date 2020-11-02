class FindPermission < ApplicationFind
  private

  def filter
    @scope = Permission.all.distinct

    filter_by_action if params.present?
    filter_by_controller if params.present?

    order_by_action_controller

    paginate
  end

  def filter_by_controller
    return unless params.controller.present?
    @scope = @scope.like_unaccent(:controller, params.controller)
  end

  def filter_by_action
    return unless params.action.present?
    @scope = @scope.like_unaccent(:action, params.action)
  end

  def order_by_action_controller
    @scope = @scope.order(:controller).order(:action)
  end
end
