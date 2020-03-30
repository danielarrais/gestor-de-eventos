class RemoveScannedSignatureToCertificateCignatures < ActiveRecord::Migration[6.0]
  def change
    remove_column :certificate_signatures, :scanned_signature
  end
end
