class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  include CScope

  def decorate
    @decorator = Object.const_get("#{self.class.name}Decorator").new(self) unless @decorator.present?
    @decorator
  end
end
