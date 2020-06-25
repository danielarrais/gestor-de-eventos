module Scope
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.instance_eval do
      scope :like_unaccent, -> (attribute, value){
        where("lower(unaccent(#{attribute})) like lower(unaccent(?))", "%#{value}%")
      }
    end
  end
end
