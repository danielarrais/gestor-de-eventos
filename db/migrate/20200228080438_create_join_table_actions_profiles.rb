class CreateJoinTableActionsProfiles < ActiveRecord::Migration[6.0]
  def change
    create_join_table :actions, :profiles do |t|
      t.index [:action_id, :profile_id]
      t.index [:profile_id, :action_id]
    end
  end
end
