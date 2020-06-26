module FormHelper
  # Processa e exibe os conteúdos dos flash enviados pelas controllers
  def validations_errors(model, margin: 4)
    return if model.errors.empty?
    content_tag :div, class: 'errors' do
      concat content_tag(:strong, alert_messages(:error, model.errors.full_messages, margin: margin))
    end
  end

  # Produz um alerta boostrap de acordo com o nível
  def alert_message(level, value)
    content_tag(:div, class: "alert #{flash_level_class(level)} alert-dismissible mt-4 fade show", role: "alert") do
      concat content_tag(:div, value).html_safe
      concat content_tag(:button, content_tag(:span, 'x', 'aria-hidden': 'true'), class: "close", 'data-dismiss': "alert", 'aria-label': "Close").html_safe
    end
  end

  # Produz um alerta boostrap de acordo com o nível
  def alert_messages(level, values, margin: 4)
    content_tag(:div, class: "alert #{flash_level_class(level)} alert-dismissible mt-#{margin} fade show", role: "alert") do
      concat(content_tag(:ul) do
        values.map do |item|
          concat content_tag(:li, item)
        end
      end.html_safe)
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

  def output_tag(method, object, value)
    class_name = object.class.to_s.underscore
    content_tag('div', class: 'form-group') do
      concat(label_tag :name, i18n_model(class_name, method))
      concat(content_tag('div') do
        label_tag(:method, value, class: 'form-control')
      end)
    end
  end

  def text_output_tag(method, object, value)
    class_name = object.class.to_s.underscore
    content_tag('div', class: 'form-group') do
      concat(label_tag :name, i18n_model(class_name, method))
      concat(content_tag('div') do
        value.html_safe
      end)
    end
  end

  def i18n_model(class_name, method = nil, plural: false, enum: nil)
    case true
    when method.present? && !enum.present?
      I18n.translate("activerecord.attributes.#{class_name}.#{method}", default: humanize(method))
    when method.present? && enum.present?
      I18n.translate("activerecord.attributes.#{class_name}.#{method}_enum.#{enum}", default: humanize(enum))
    else
      I18n.translate("activerecord.models.#{class_name}.#{plural ? :other : :one }", default: humanize(class_name, plural))
    end
  end

  def humanize(simbol, plural = false)
    simbol = plural ? simbol.to_s : simbol.to_s.pluralize
    simbol.humanize
  end

  def i18n_word(word)
    I18n.translate("words.#{word}", default: word.to_s.humanize)
  end

  def i18n_placeholder(model, method)
    i18n_key = "helpers.placeholder.#{model}.#{method}"
    I18n.translate(i18n_key, default: method.to_s.humanize)
  end

  # Retornar uma URL de imagem fake com base nos paramêtros
  def url_image_fake(resolution:, text: nil, image_color: '0a0c0d', text_color: 'fff', text_size: '15')
    "https://fakeimg.pl/#{resolution}/#{image_color},100/#{text_color},255?retina=1&font_size=#{text_size}&text=#{text ||= resolution}"
  end

  def summernote_area_tag(name, options = {})
    options[:rows] = options[:rows] || 20
    value = options[:value]
    add_class options, 'summernote'

    text_area_tag name, value, options
  end

  def add_class(options, css_class)
    options[:class] = [] unless options[:class].present?
    options[:class] << " #{css_class}"
  end

  def clear_form_button
    button_tag(:class => "btn btn-light btn-icon btn-1 btn-simple pull", type: 'button',
               onclick: "clearForm('#new_filter')") do
      '<span><i class="fa fa-refresh"></i></span>'.html_safe
    end
  end
end