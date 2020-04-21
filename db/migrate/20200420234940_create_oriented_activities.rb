class CreateOrientedActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :oriented_activities do |t|
      t.string :title, null: false
      t.bigint :event_category_id, null: false

      t.timestamps
    end
  end
end
