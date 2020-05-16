class CreateEventRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :event_requests do |t|
      t.text :additional_information, null: true
      t.bigint :person_id, null: false
      t.bigint :event_id, null: false

      t.timestamps
    end
  end
end
