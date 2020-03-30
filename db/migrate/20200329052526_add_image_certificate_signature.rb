class AddImageCertificateSignature < ActiveRecord::Migration[6.0]
  def change
    add_column :certificate_signatures, :image_id, :bigint, null: false

    add_foreign_key :certificate_signatures, :images, index: true
  end
end