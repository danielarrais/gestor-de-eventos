class CertificateTemplateSituation < ActiveRecord::Migration[6.0]
  def change
    add_reference :certificate_templates, :situation, null: true, foreign_key: true
  end
end
