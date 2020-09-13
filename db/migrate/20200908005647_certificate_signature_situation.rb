class CertificateSignatureSituation < ActiveRecord::Migration[6.0]
  def change
    add_reference :certificate_signatures, :situation, null: true, foreign_key: true
  end
end
