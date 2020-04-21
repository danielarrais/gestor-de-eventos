class Course < ApplicationRecord
  validates_presence_of :name, :number_of_semesters
end
