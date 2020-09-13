class CertificateSignature < ApplicationRecord
  include CSituation

  belongs_to :image, required: true
  has_and_belongs_to_many :certificate_template
  has_and_belongs_to_many :certificate_signature

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) {x[:file].nil?}

  def archive

  end
end
