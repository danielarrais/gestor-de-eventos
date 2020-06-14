class Permission < ApplicationRecord
  has_and_belongs_to_many :profiles

  validates_presence_of :name, :description

  def self.import_from_controllers(controllers)
    permissions = []
    controllers.each do |controller|
      controller_class = Object.const_get(controller.to_s)
      action_methods_name = Object.const_get(controller_class.name).action_methods

      action_methods_name.each do |action|
        controller_formated_name = controller_class.name.underscore

        saved_action = Permission.where(action: action, controller: controller_formated_name).first

        unless saved_action.present?
          permissions << { name: "#{controller_class.name}##{action}",
                           description: "#{controller_class.name}##{action}",
                           controller: controller_class.name.underscore,
                           action: action,
                           created_at: Time.now,
                           updated_at: Time.now }
        end
      end
    end
    # p permissions.first.attributes
    Permission.insert_all(permissions) if permissions.any?
  end
end
