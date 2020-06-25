class FindEvent < ApplicationFind
  private

  def filter(params, page_params)
    @scope = Event.all.distinct

    filter_drafts
    filter_by_name(params[:name]) if params.present?
    filter_by_category(params[:event_category_id]) if params.present?
    filter_by_start_date(params[:start_date]) if params.present?
    filter_by_closing_date(params[:closing_date]) if params.present?

    paginate(page_params)
  end

  def filter_by_name(param)
    return if !param.present? || param.blank?
    @scope = @scope.like_unaccent(:name, param)
  end

  def filter_drafts
    @scope = @scope.no_draft.where(parent_event: nil)
  end

  def filter_by_category(param)
    return if !param.present? || param.blank?
    @scope = @scope.where(event_category_id: param.to_i)
  end

  def filter_by_start_date(param)
    return if !param.present? || param.blank?
    @scope = @scope.date_equals(:start_date, param)
  end

  def filter_by_closing_date(param)
    return if !param.present? || param.blank?
    @scope = @scope.date_equals(:closing_date, param)
  end

end