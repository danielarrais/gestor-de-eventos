class AddFkEventsEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :event_id, :bigint

    add_foreign_key :events, :events, index: true
  end
end
