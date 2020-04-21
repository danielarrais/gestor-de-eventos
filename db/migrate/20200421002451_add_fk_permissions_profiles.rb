class AddFkPermissionsProfiles < ActiveRecord::Migration[6.0]
  def change
    add_reference :permissions_profiles, :permissions, foreign_key: true
    add_reference :permissions_profiles, :profiles, foreign_key: true
  end
end
