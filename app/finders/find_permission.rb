class FindPermission < ApplicationFind
  private

  def filter
    @scope = Permission.all.distinct

    filter_by_name if params.present?
    filter_by_description if params.present?

    paginate
  end

  def filter_by_description
    return unless params.description.present?
    @scope = @scope.like_unaccent(:description, params.description)
  end

  def filter_by_name
    return unless params.name.present?
    @scope = @scope.like_unaccent(:name, params.name)
  end
end