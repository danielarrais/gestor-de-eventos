module Scope
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.instance_eval do
      scope :like_unaccent, -> (attribute, value) {
        where("lower(unaccent(#{attribute})) like lower(unaccent(?))", "%#{value}%")
      }
      scope :date_equals, -> (attribute, value) {
        where("to_date(to_char(#{attribute}, 'YYYY-MM-DD'),'YYYY-MM-DD') = ?::date", value.to_date.strftime("%Y-%m-%d"))
      }
    end
  end
end
