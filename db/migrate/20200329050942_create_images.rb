class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :format, null: false
      t.binary :content, null: false
      t.timestamps
    end
  end
end
