class FindCertificateSignature < ApplicationFind
  private

  def filter
    @scope = CertificateSignature.all.distinct

    filter_unarchiveds
    filter_archived if params.present?
    filter_by_name if params.present?
    filter_by_role if params.present?

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

  def filter_by_name
    return unless params.name.present?
    @scope = @scope.like_unaccent(:name, params.name)
  end

  def filter_by_role
    return unless params.role.present?
    @scope = @scope.like_unaccent(:role, params.role)
  end
end
