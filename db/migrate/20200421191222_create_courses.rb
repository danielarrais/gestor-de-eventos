class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.integer :number_of_semesters, null: false

      t.timestamps
    end
  end
end
