class ApplicationFind
  private_class_method :new
  attr_accessor :initial_scope

  def self.find(params, page_params = nil)
    self.new.send(:filter, params, page_params)
  end

  private

  def paginate(params)
    @scope.page(params[:page]).per(10)
  end
end