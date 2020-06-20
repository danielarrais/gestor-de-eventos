class Frequence < ApplicationRecord
  belongs_to :event
  has_many :participants
end
