class CertificateTemplate < ApplicationRecord
  belongs_to :image, required: false
  belongs_to :person, required: false
  belongs_to :event_category, required: false
  has_and_belongs_to_many :certificate_signatures

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) {x[:file].nil?}
end
