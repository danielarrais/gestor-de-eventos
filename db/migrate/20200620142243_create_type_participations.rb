class CreateTypeParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :type_participations do |t|
      t.string :name, null: false
      t.string :key, null: false

      t.timestamps
    end
  end
end
