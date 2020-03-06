module FormHelper

  # Processa e exibe os conteúdos dos flash enviados pelas controllers
  def validations_errors(model)
    return if model.errors.empty?
    content_tag :div do
      model.errors.full_messages.each do |value|
        concat content_tag(:strong, alert_message(:error, value))
      end
    end
  end

  # Produz um alerta boostrap de acordo com o nível
  def alert_message(level, value)
    content_tag(:div, class: "alert #{flash_level_class(level)} alert-dismissible mt-4 fade show", role: "alert") do
      concat content_tag(:div, value).html_safe
      concat content_tag(:button, content_tag(:span, 'x', 'aria-hidden': 'true'), class: "close", 'data-dismiss': "alert", 'aria-label': "Close").html_safe
    end
  end

  # Retorna uma class CSS de nivel (info, sucess, danger e warning) de acordo com o symbol passado
  def flash_level_class(key)
    case key
    when :notice then
      "alert-info"
    when :success then
      "alert-success"
    when :error then
      "alert-danger"
    when :alert then
      "alert-warning"
    else
      # type code here
    end
  end
end
