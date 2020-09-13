class FindTypeParticipation < ApplicationFind
  private

  def filter
    @scope = TypeParticipation.all.distinct

    filter_by_name if params.present?

    paginate
  end

  def filter_by_name
    return unless params.name.present?
    @scope = @scope.like_unaccent(:name, params.name)
  end
end