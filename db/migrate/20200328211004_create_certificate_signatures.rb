class CreateCertificateSignatures < ActiveRecord::Migration[6.0]
  def change
    create_table :certificate_signatures do |t|

      t.timestamps
    end
  end
end
