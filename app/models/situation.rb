class Situation < ApplicationRecord
  belongs_to :origin, polymorphic: true
  belongs_to :person
  belongs_to :key_situation

  def situation_description
    key_situation.description
  end
end
