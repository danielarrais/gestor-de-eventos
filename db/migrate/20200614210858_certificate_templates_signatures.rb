class CertificateTemplatesSignatures < ActiveRecord::Migration[6.0]
  def change
    create_join_table :certificate_templates, :certificate_signatures

    add_foreign_key :certificate_signatures_templates, :certificate_templates, index: true
    add_foreign_key :certificate_signatures_templates, :certificate_signatures, index: true
  end
end
