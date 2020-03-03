class Profile < ApplicationRecord
  has_and_belongs_to_many :actions
  has_and_belongs_to_many :users
end
