class Person < ApplicationRecord

  validates_presence_of :name, :surname, :cpf, :date_of_birth
  validates_cpf_format_of :cpf, :allow_blank => true

end
