class CreateGuideds < ActiveRecord::Migration[6.0]
  def change
    create_table :guideds do |t|
      t.bigint :person_id, null: false
      t.bigint :course_id, null: false
      t.bigint :semester, null: false
      t.timestamps
    end

    add_foreign_key :guideds, :people, index: true
  end
end
