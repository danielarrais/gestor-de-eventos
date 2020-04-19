class Util
  def self.genarate_random_string(length = 10)
    (0...25).map { (65 + rand(26)).chr }.join
  end
end