class DraftEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :draft, :boolean, default: false
  end
end
