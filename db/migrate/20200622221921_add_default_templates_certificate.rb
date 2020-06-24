class AddDefaultTemplatesCertificate < ActiveRecord::Migration[6.0]
  def change
    add_column :certificate_templates, :default, :boolean, default: false
  end
end
