Dir["#{Rails.root}/app/controllers/*.rb"].each { |file| require_dependency file }

namespace :profiles do
  desc "Records the names of the controllers' actions in the database"
  task generate_actions: :environment do
    controllers = ApplicationController.subclasses

    controllers.each do |controller|
      puts "Controller #{controller}"
      controller_class = Object.const_get(controller.to_s)
      action_methods_name = Object.const_get(controller_class.name).action_methods

      action_methods_name.each do |action|
        controller_formated_name = controller_class.name.underscore

        saved_action = Action.where(action: action, controller: controller_formated_name).first

        if saved_action.present?
          puts "Action #{action} already exists"
        else
          Action.new(name: "#{controller_class.name}##{action}",
                     description: "#{controller_class.name}##{action}",
                     controller: controller_class.name.underscore,
                     action: action).save
          puts "Action #{action} created"
        end
      end
      puts ""
    end
  end

  desc "Renames the controller name of the actions"
  task change_name_control: :environment do
    ARGV.each { |a| task a.to_sym do ; end }

    older_control_name = ARGV[1].to_s.underscore
    new_control_name = ARGV[2].to_s.underscore

    Action.where(controller: older_control_name).each do |action|
      action.update_columns(controller: new_control_name)
      puts "#{action.name} updated"
    end

  end
end
