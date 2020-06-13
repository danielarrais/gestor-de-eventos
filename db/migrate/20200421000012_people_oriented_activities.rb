class PeopleOrientedActivities < ActiveRecord::Migration[6.0]
  def change
      create_join_table :oriented_activities, :people, column_options: { index: true }

      add_foreign_key :oriented_activities_people, :oriented_activities, index: true
      add_foreign_key :oriented_activities_people, :people, index: true
    end
end
