class AddReferencesInEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events,  :certificate_template, null: true, foreign_key: true
    add_reference :events, :situation, null: false, foreign_key: true
    remove_column :events, :draft
  end
end
