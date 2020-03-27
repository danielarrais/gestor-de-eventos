class RenameActionToPermission < ActiveRecord::Migration[6.0]
  def change
    rename_table :actions, :permissions
    rename_table :actions_profiles, :permissions_profiles

    rename_column :permissions_profiles, :action_id, :permission_id
  end
end
