class CertificateSignature < ApplicationRecord
  include CSituation

  belongs_to :image, required: true
  has_and_belongs_to_many :certificate_template
  has_and_belongs_to_many :certificate_signature

  validates_presence_of :role

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) {x[:file].nil?}

  def archive
    return if archived?

    self.situations.create(person: current_user.person,
                           observation: '',
                           key_situation: KeySituation.find_by(key: :archived)).save

    set_current_situation
  end

  def unarchive
    return unless archived?

    self.situations.create(person: current_user.person,
                           observation: '',
                           key_situation: KeySituation.find_by(key: :unarchived)).save

    set_current_situation
  end
end
