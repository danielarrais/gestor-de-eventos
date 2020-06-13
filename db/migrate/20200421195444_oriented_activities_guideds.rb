class OrientedActivitiesGuideds < ActiveRecord::Migration[6.0]
  def change
    create_join_table :oriented_activities, :guideds

    add_foreign_key :guideds_oriented_activities, :oriented_activities, index: true
    add_foreign_key :guideds_oriented_activities, :guideds, index: true
  end
end
