require 'cancancan'

class ApplicationDecorator
  attr_accessor :model

  def initialize(model)
    @model = model
  end
end
