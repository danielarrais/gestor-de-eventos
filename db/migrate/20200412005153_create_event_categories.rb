class CreateEventCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :event_categories do |t|
      t.string :name
      t.string :description, null: false

      t.timestamps
    end
  end
end