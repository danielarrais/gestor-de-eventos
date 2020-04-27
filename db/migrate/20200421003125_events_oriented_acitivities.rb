class EventsOrientedAcitivities < ActiveRecord::Migration[6.0]
  def change
    create_join_table :events, :oriented_activities

    add_foreign_key :events_oriented_activities, :events, index: true
    add_foreign_key :events_oriented_activities, :oriented_activities, index: true
  end
end
