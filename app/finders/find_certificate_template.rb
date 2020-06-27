class FindCertificateTemplate < ApplicationFind
  private

  def filter
    @scope = CertificateTemplate.all.distinct

    filter_by_signatures if params.present?
    filter_by_category if params.present?

    paginate
  end

  def filter_by_signatures
    return if !params.certificate_signatures.present? || params.certificate_signatures.reject { |x| x.blank? }.empty?
    @scope = @scope.joins(:certificate_signatures)
    @scope = @scope.where('certificate_signatures.id in (?)', params.certificate_signatures.reject { |x| x.blank? })
  end

  def filter_by_category
    return unless params.name.present?
    @scope = @scope.where(event_category_id: params.name)
  end
end