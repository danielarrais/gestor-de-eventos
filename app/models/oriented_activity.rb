class OrientedActivity < ApplicationRecord
  alias_attribute :advisors, :people

  has_and_belongs_to_many :people # use alias guiding
  has_and_belongs_to_many :guideds

  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :guideds
end
