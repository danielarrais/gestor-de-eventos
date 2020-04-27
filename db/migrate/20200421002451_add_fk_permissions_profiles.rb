class AddFkPermissionsProfiles < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :permissions_profiles, :permissions, index: true
    add_foreign_key :permissions_profiles, :profiles, index: true
  end
end
