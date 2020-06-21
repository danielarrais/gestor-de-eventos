class CreateArchives < ActiveRecord::Migration[6.0]
  def change
    create_table :archives do |t|
      t.references :origin, polymorphic: true, null: false
      t.string :name, null: false
      t.binary :content, null: false
      t.string :format, null: false

      t.timestamps
    end
  end
end
