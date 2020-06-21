class Frequence < ApplicationRecord
  belongs_to :event
  has_many :participants, -> { order(name: :asc).order(surname: :asc).order(id: :asc) }
end