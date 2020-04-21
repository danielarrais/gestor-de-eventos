class Event < ApplicationRecord
  belongs_to :image
  belongs_to :event_category

  has_and_belongs_to_many :oriented_activities # use alias guiding

  validates_presence_of :name, :start_date, :closing_date, :event_category, :workload

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) {x[:file].nil?}
  accepts_nested_attributes_for :oriented_activities, allow_destroy: true
end
