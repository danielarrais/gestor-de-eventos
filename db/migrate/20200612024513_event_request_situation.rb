class EventRequestSituation < ActiveRecord::Migration[6.0]
  def change
    add_reference :event_requests, :situation, null: true, foreign_key: true
  end
end
