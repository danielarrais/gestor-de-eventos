class FindCertificateSignature < ApplicationFind
  private

  def filter
    @scope = CertificateSignature.all.distinct

    filter_by_name if params.present?
    filter_by_role if params.present?

    paginate
  end

  def filter_by_name
    return unless params.name.present?
    @scope = @scope.like_unaccent(:name, params.name)
  end

  def filter_by_role
    return unless params.role.present?
    @scope = @scope.like_unaccent(:role, params.role)
  end
end