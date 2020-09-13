class FindCertificateTemplate < ApplicationFind
  private

  def filter
    @scope = CertificateTemplate.all.distinct

    filter_unarchiveds
    filter_archived if params.present?
    filter_by_signatures if params.present?
    filter_by_category if params.present?

    paginate
  end

  def filter_archived
    return unless params.archived?
    @scope = @scope.joins(situation: [:key_situation])
    @scope = @scope.where('key_situations.key': :archived)
  end

  def filter_unarchiveds
    return if params.archived?
    @scope = @scope.left_joins(situation: [:key_situation])
    @scope = @scope.where("key_situations.key = '#{:unarchived}' or situation_id is null")
  end

  def filter_by_signatures
    return if !params.certificate_signatures.present? || params.certificate_signatures.reject { |x| x.blank? }.empty?
    @scope = @scope.joins(:certificate_signatures)
    @scope = @scope.where('certificate_signatures.id in (?)', params.certificate_signatures.reject { |x| x.blank? })
  end

  def filter_by_category
    return unless params.event_category.present?
    @scope = @scope.where(event_category_id: params.event_category)
  end
end
