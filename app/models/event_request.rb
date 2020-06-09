class EventRequest < ApplicationRecord
  belongs_to :event
  belongs_to :person, required: false
  has_one :situation, -> { order('created_at desc').limit(1) }, as: :origin
  has_many :situations, -> { order('created_at asc') }, as: :origin

  accepts_nested_attributes_for :event, allow_destroy: false
end
