class AddCertificateHashParticipant < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :certificate_hash, :string, unique: true
  end
end
