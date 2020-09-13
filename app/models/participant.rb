require "zlib"
require 'securerandom'

class Participant < ApplicationRecord
#   belongs_to :person, required: false
  belongs_to :frequence, required: false
  belongs_to :type_participation, required: false
  belongs_to :event, required: false

  before_update :generate_hash

  before_validation :format_cpf
  validates_cpf_format_of :cpf

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

  def generate_hash
    if certified? && !self.certificate_hash.present?
      self.certificate_hash = Zlib.adler32(SecureRandom.uuid).to_s(16)
    end
  end

  def format_cpf
    return unless self.cpf.present?

    cpf_numbers = cpf.gsub(/\D/, '')
    self.cpf = CPF.new(cpf_numbers).formatted
  end
end