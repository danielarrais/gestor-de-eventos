class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :frequence, null: true, foreign_key: true
      t.references :type_participation, null: true, foreign_key: true
      t.references :event, null: true, foreign_key: true
      t.string :email, null: true
      t.string :name, null: true
      t.string :surname, null: true
      t.string :registration, null: true
      t.string :cpf, null: true
      t.integer :status, null: true
      t.integer :workload, null: true

      t.timestamps
    end
  end
end
