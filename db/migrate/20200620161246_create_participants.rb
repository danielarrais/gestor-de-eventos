class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :person, null: false, foreign_key: true
      t.references :frequence, null: false, foreign_key: true
      t.references :type_participation, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.string :email, null: true
      t.integer :status
      t.integer :workload

      t.timestamps
    end
  end
end
