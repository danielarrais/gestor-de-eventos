class AddColunmPublicTableActions < ActiveRecord::Migration[6.0]
  def change
    add_column :actions, :public, :boolean, default: false
  end
end
