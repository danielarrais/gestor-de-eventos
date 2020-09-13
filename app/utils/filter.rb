class Filter
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize(attributes = {})
    attributes.each do |k, v|
      self.instance_variable_set("@#{k}", v)
      self.class.send(:define_method, k, proc { self.instance_variable_get("@#{k}") })
      self.class.send(:define_method, "#{k}?", proc { self.instance_variable_get("@#{k}") }) if is_boolean?(v)
      self.class.send(:define_method, "#{k}=", proc { |v| self.instance_variable_set("@#{k}", v) })
    end
  end

  def to_h
  end

  def is_boolean?(value)
    [true, false].include? value
  end
end
