Dir["#{Rails.root}/app/controllers/*.rb"].each { |file| require_dependency file }

namespace :profiles do
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
