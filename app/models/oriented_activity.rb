class OrientedActivity < ApplicationRecord
  alias_attribute :advisors, :people

  has_and_belongs_to_many :people # use alias guiding
  accepts_nested_attributes_for :people
end
