class FindCourse < ApplicationFind
  private

  def filter(params, page_params)
    @scope = CertificateTemplate.all.distinct

    paginate(page_params)
  end

end