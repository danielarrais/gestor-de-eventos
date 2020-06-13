class ChangeImageEvent < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :image_id, :bigint, null: true
  end
end
