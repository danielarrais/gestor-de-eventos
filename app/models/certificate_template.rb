class CertificateTemplate < ApplicationRecord
  belongs_to :image, required: false
  belongs_to :person, required: false
  belongs_to :event_category, required: false
end
