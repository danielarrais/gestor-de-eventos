class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.boolean :custom, null: true

      t.timestamps
    end
  end
end
