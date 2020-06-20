class Participant < ApplicationRecord
  belongs_to :person
  belongs_to :frequence
  belongs_to :type_participation
  belongs_to :event
end
