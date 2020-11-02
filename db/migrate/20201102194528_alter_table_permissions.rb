class AlterTablePermissions < ActiveRecord::Migration[6.0]
  def change
    remove_column :permissions, :description

    rename_column :permissions, :controller, :controller_key
    add_column :permissions, :controller, :string, :null => false

    rename_column :permissions, :action, :action_key
    rename_column :permissions, :name, :action

    add_column :permissions, :equivalent_actions, :text
  end
end
