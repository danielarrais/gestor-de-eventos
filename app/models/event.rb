class Event < ApplicationRecord
  belongs_to :image
  belongs_to :event_category
end
