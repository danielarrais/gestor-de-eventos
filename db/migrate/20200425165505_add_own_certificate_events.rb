class AddOwnCertificateEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :own_certificate, :boolean, default: false
  end
end
