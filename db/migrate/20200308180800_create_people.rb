class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :registration, null: true
      t.string :cpf, null: false
      t.string :name, null: false
      t.string :surname, null: false
      t.string :cellphone, null: true
      t.datetime :date_of_birth, null: false

      t.timestamps
    end
  end
end
