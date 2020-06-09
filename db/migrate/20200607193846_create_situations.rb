class CreateSituations < ActiveRecord::Migration[6.0]
  def change
    create_table :situations do |t|
      t.references :key_situation, null: false, foreign_key: true
      t.text :observation
      t.references :origin, polymorphic: true, null: false
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
