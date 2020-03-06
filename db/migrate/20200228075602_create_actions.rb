class CreateActions < ActiveRecord::Migration[6.0]
  def change
    create_table :actions do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.string :controller, null: false
      t.string :action, null: false

      t.timestamps
    end
  end
end
