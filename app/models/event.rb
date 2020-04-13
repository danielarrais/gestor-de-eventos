class Event < ApplicationRecord
  belongs_to :image
  belongs_to :event_category

  validates_presence_of :name, :start_date, :closing_date, :event_category, :workload

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) {x[:file].nil?}
end
