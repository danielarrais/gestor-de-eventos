class Action < ApplicationRecord
  has_and_belongs_to_many :profiles

  validates_presence_of :name, :description
end
