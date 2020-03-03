class CreateJoinTableUserProfiles < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :profiles do |t|
      t.index [:user_id, :profile_id]
      t.index [:profile_id, :user_id]
    end
  end
end
