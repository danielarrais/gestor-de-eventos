class FindEventRequest < ApplicationFind
  private

  def filter
    @scope = EventRequest.all.distinct
    @scope = @scope.joins(:event)

    # find_waiting_for_analysis
    filter_by_name if params.present?
    filter_by_category if params.present?
    filter_by_situation if params.present?
    filter_by_closing_date if params.present?
    filter_by_start_date if params.present?
    filter_by_person if extras.present?

    paginate
  end

  def find_waiting_for_analysis
    return unless extras[:waiting_for_analysis]
    @scope = @scope.waiting_for_analysis
  end

  def filter_by_name
    return unless params.name.present?
    @scope = @scope.like_unaccent("events.name", params.name)
  end

  def filter_by_category
    return unless params.event_category.present?
    @scope = @scope.where("events.event_category_id": params.event_category)
  end

  def filter_by_situation
    return unless params.situation.present?
    @scope = @scope.joins(situation: [:key_situation])
    @scope = @scope.where("key_situations.id": params.situation)
  end

  def filter_by_start_date
    return unless params.start_date.present?
    @scope = @scope.date_equals(:start_date, params.start_date)
  end

  def filter_by_closing_date
    return unless params.closing_date.present?
    @scope = @scope.date_equals(:closing_date, params.closing_date)
  end

  def filter_by_person
    return unless extras[:person].present?
    @scope = @scope.where(person_id: extras[:person])
  end
end