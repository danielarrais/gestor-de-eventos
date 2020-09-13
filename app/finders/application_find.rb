class ApplicationFind
  private_class_method :new
  attr_accessor :scope, :params, :page_params, :extras

  def self.find(params, page_params = nil, extras = nil)
    self.new(params, page_params, *extras).send(:filter)
  end

  private

  def initialize(params, page_params, extras = {})
    @params, @page_params, @extras = params, page_params, extras
  end

  def paginate
    @scope.page(page_params[:page]).per(10)
  end
end