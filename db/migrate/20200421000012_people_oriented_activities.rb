class PeopleOrientedActivities < ActiveRecord::Migration[6.0]
  def change
      create_join_table :oriented_activities, :people, column_options: { index: true }

      add_reference :oriented_activities_people, :oriented_activities, foreign_key: true
      add_reference :oriented_activities_people, :people, foreign_key: true
    end
end
