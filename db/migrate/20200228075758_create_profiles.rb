class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :description
      t.boolean :custom

      t.timestamps
    end
  end
end
