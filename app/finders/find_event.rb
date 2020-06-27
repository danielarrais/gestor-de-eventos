class FindEvent < ApplicationFind
  private

  def filter
    @scope = Event.all.distinct

    filter_drafts
    filter_by_name if params.present?
    filter_by_category if params.present?
    filter_by_start_date if params.present?
    filter_by_closing_date if params.present?
    filter_by_situation if params.present?

    paginate
  end

  def filter_by_name
    return unless params.name.present?
    @scope = @scope.like_unaccent(:name, params.name)
  end

  def filter_drafts
    @scope = @scope.no_draft.where(parent_event: nil)
  end

  def filter_by_category
    return unless params.event_category.present?
    @scope = @scope.where(event_category: params.event_category.to_i)
  end

  def filter_by_start_date
    return unless params.start_date.present?
    @scope = @scope.date_equals(:start_date, params.start_date)
  end

  def filter_by_closing_date
    return unless params.closing_date.present?
    @scope = @scope.date_equals(:closing_date, params.closing_date)
  end

  def filter_by_situation
    return unless params.situation.present?
    @scope = @scope.joins(situation: [:key_situation])
    @scope = @scope.where("key_situations.id": params.situation)
  end

end