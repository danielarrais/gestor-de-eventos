class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.timestamp :start_date, null: false
      t.timestamp :closing_date, null: false
      t.bigint :event_category_id, null: false
      t.bigint :image_id, null: false
      t.integer :workload, null: false

      t.timestamps
    end

    add_foreign_key :events, :images
    add_foreign_key :events, :event_categories
  end
end
