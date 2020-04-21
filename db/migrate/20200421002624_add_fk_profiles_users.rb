class AddFkProfilesUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :profiles_users, :users, foreign_key: true
    add_reference :profiles_users, :profiles, foreign_key: true
  end
end
