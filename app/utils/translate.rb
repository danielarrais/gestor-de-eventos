class Translate
  def self.translate_permission_controller(controller_name)
    controller_nameu = controller_name.underscore.gsub('_controller', '')
    I18n.t("permissions.#{controller_nameu}.name", "#{controller_name}")
  end

  def self.translate_permission_action(controller_name, action)
    controller_nameu = controller_name.underscore.gsub('_controller', '')
    I18n.t("permissions.#{controller_nameu}.actions.#{action}", default: nil)
  end
end
