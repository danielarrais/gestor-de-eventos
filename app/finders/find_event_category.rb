class FindEventCategory < ApplicationFind
  private

  def filter(params, page_params)
    @scope = EventCategory.all.distinct

    filter_by_name(params[:name]) if params.present?
    filter_by_description(params[:description]) if params.present?

    paginate(page_params)
  end

  def filter_by_name(param)
    return if !param.present? || param.blank?
    @scope = @scope.like_unaccent(:name, param)
  end

  def filter_by_description(param)
    return if !param.present? || param.blank?
    @scope = @scope.like_unaccent(:description, param)
  end

end