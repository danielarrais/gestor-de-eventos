class CreateCertificateSignatures < ActiveRecord::Migration[6.0]
  def change
    create_table :certificate_signatures do |t|
      t.string :name, null: false
      t.string :role, null: false

      t.timestamps
    end
  end
end
