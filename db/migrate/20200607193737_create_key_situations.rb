class CreateKeySituations < ActiveRecord::Migration[6.0]
  def change
    create_table :key_situations do |t|
      t.string :key, unique: true, null: false
      t.string :description
      t.string :description_female

      t.timestamps
    end
  end
end
