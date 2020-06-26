class FindCertificateTemplate < ApplicationFind
  private

  def filter
    @scope = CertificateTemplate.all.distinct

    filter_by_signatures(params[:certificate_signature_ids]) if params.present?
    filter_by_category(params[:event_category_id]) if params.present?

    paginate
  end

  def filter_by_signatures(param)
    return if !param.present? || param.reject { |x| x.blank? }.empty?
    @scope = @scope.joins(:certificate_signatures)
    @scope = @scope.where('certificate_signatures.id in (?)', param.reject { |x| x.blank? })
  end

  def filter_by_category(param)
    return unless param.present?
    @scope = @scope.where(event_category_id: param)
  end
end