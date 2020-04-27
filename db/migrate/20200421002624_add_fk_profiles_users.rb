class AddFkProfilesUsers < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :profiles_users, :users, index: true
    add_foreign_key :profiles_users, :profiles, index: true
  end
end
