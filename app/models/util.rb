class Util
  def self.genarate_random_string(length = 10)
    (0...length).map { (65 + rand(26)).chr }.join
  end

  def self.to_boolean(value)
    ActiveModel::Type::Boolean.new.cast(value || false)
  end
end
