class EventRequest < ApplicationRecord
  belongs_to :event
  belongs_to :person, required: false

  accepts_nested_attributes_for :event, allow_destroy: false
end
