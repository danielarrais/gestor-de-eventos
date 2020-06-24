class FindCertificateTemplate
  private_class_method :new
  attr_accessor :initial_scope

  def self.find(params, page_params = nil)
    self.new.send(:filter, params, page_params)
  end

  private

  def filter(params, page_params)
    @scope = CertificateTemplate.all.distinct

    scoped = filter_by_signatures(@scope, params[:certificate_signature_ids])
    scoped = filter_by_category(scoped, params[:event_category_id])

    paginate(scoped, page_params)
  end

  def filter_by_signatures(scoped, param)
    return scoped if !param.present? || param.reject { |x| x.blank? }.empty?
    scoped = scoped.joins(:certificate_signatures)
    scoped.where('certificate_signatures.id in (?)', param.reject { |x| x.blank? })
  end

  def filter_by_category(scoped, param)
    return scoped unless param.present?
    scoped.where(event_category_id: param)
  end

  def paginate(scoped, params)
    scoped = scoped.page(params[:page]).per(10)
  end
end