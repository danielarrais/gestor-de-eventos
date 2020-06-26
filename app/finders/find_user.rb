class FindUser < ApplicationFind
  private

  def filter
    @scope = User.all.distinct

    filter_by_name if params.present?
    filter_by_email if params.present?
    filter_by_cpf if params.present?

    paginate
  end

  def filter_by_email
    return unless params.name.present?
    @scope = @scope.like_unaccent(:name, params.name)
  end

  def filter_by_cpf
    return unless params.cpf.present?
    @scope = @scope.joins(:person)
    @scope = @scope.like_unaccent('people.cpf', params.cpf)
  end

  def filter_by_name
    return unless params.email.present?
    @scope = @scope.like_unaccent(:email, params.email)
  end
end