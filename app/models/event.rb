class Event < ApplicationRecord
  belongs_to :image, required: false
  belongs_to :parent_event, class_name: 'Event', foreign_key: 'event_id', required: false
  belongs_to :event_category
  belongs_to :participants

  has_many :child_events, :class_name => "Event"

  has_and_belongs_to_many :oriented_activities # use alias guiding

  validates_presence_of :name, :start_date, :closing_date, :event_category, :workload

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) {x[:file].nil?}
  accepts_nested_attributes_for :oriented_activities, allow_destroy: true
  accepts_nested_attributes_for :child_events, allow_destroy: true
end
