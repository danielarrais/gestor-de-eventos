class Participant < ApplicationRecord
#   belongs_to :person, required: false
  belongs_to :frequence, required: false
  belongs_to :type_participation, required: false
  belongs_to :event, required: false

  # accepts_nested_attributes_for :person, allow_destroy: true

  # before_validation :set_person

  enum status: { confirmed_subscription: 1,
                 awaiting_certificate: 2,
                 certified: 4,
                 unsubscribed: 3 }

  def full_name
    [self.name, self.surname].join(' ')
  end

  def workload_s
    "#{workload} #{workload == 1 ? 'Hora' : 'Horas'}"
  end

  private

  # def set_person
  #   return unless self.person.present?
  #   if self.person.new_record? && self.person.cpf.present?
  #     equal_person = Person.find_by_cpf(self.person.cpf)
  #     self.person = equal_person if equal_person.present?
  #   end
  # end
end