class CreateCertificateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :certificate_templates do |t|
      t.text :body, null: false
      t.references :image, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.references :event_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
