class FindParticipant < ApplicationFind
  private

  def filter
    @scope = Participant.all.distinct
    @scope = @scope.joins(:event)

    filter_by_name if params.present?
    filter_by_category if params.present?
    filter_by_type_participation if params.present?
    filter_by_workload if params.present?
    filter_by_closing_date if params.present?
    filter_by_start_date if params.present?
    filter_by_cpf if params.present?
    filter_by_status if params.present?

    paginate
  end

  def filter_by_name
    return unless params.name.present?
    @scope = @scope.like_unaccent("events.name", params.name)
  end

  def filter_by_category
    return unless params.event_category.present?
    @scope = @scope.where("events.event_category_id": params.event_category)
  end

  def filter_by_type_participation
    return unless params.type_participation.present?
    @scope = @scope.where(type_participation_id: params.type_participation)
  end

  def filter_by_start_date
    return unless params.start_date.present?
    @scope = @scope.date_equals('events.start_date', params.start_date)
  end

  def filter_by_closing_date
    return unless params.closing_date.present?
    @scope = @scope.date_equals('events.closing_date', params.closing_date)
  end

  def filter_by_workload
    return unless params.workload.present?
    @scope = @scope.where(workload: params.workload)
  end

  def filter_by_cpf
    return unless extras[:cpf].present?
    @scope = @scope.where(cpf: extras[:cpf])
  end

  def filter_by_status
    return unless extras[:status].present?
    @scope = @scope.where(status: extras[:status])
  end
end