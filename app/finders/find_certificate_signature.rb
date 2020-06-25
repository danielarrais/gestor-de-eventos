class FindCertificateSignature < ApplicationFind
  private

  def filter(params, page_params)
    @scope = CertificateSignature.all.distinct

    filter_by_name(params[:name]) if params.present?
    filter_by_role(params[:role]) if params.present?

    paginate(page_params)
  end

  def filter_by_name(param)
    return if !param.present? || param.blank?
    @scope = @scope.like_unaccent(:name, param)
  end

  def filter_by_role(param)
    return if !param.present? || param.blank?
    @scope = @scope.like_unaccent(:role, param)
  end
end