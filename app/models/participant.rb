class Participant < ApplicationRecord
  belongs_to :person, required: false
  belongs_to :frequence
  belongs_to :type_participation
  belongs_to :event

  accepts_nested_attributes_for :person, allow_destroy: true

  before_validation :set_person

  private

  def set_person
    return unless self.person.present?
    if self.person.new_record? && self.person.cpf.present?
      equal_person = Person.find_by_cpf(self.person.cpf)
      self.person = equal_person if equal_person.present?
    end
  end
end