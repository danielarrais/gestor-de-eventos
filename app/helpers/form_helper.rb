module FormHelper
  # Processa e exibe os conteúdos dos flash enviados pelas controllers
  def validations_errors(model)
    return if model.errors.empty?
    content_tag :div do
      concat content_tag(:strong, alert_messages(:error, model.errors.full_messages))
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
  def alert_messages(level, values)
    content_tag(:div, class: "alert #{flash_level_class(level)} alert-dismissible mt-4 fade show", role: "alert") do
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

  def i18n_model(class_name, method)
    I18n.translate("activerecord.attributes.#{class_name}.#{method}", default: method)
  end

  # Retornar uma URL de imagem fake com base nos paramêtros
  def url_image_fake(resolution:, text: nil, image_color: '0a0c0d', text_color: 'fff', text_size: '15')
    "https://fakeimg.pl/#{resolution}/#{image_color},100/#{text_color},255?retina=1&font_size=#{text_size}&text=#{text ||= resolution}"
  end

  # Cria label para colocar traduções alternativas
  def label(*sources)
    if sources[0].to_s.include? '['
      i18n_key = "activerecord.attributes.#{sources[0]}/#{sources[1]}".remove('_attributes', ']').gsub('[', '.')
      sources[2] = I18n.translate(i18n_key, default: nil)
    end
    super *sources
  end

  # Usa placeholders para inserir uma opção em branco no select
  def select(*sources)
    if sources[3][:include_blank] == true
      i18n_key = "helpers.placeholder.#{sources[0]}.#{sources[1]}"
      sources[3][:include_blank] = I18n.translate(i18n_key, default: "")
    end
    super *sources
  end
end

class ArgonFormBuilder < ActionView::Helpers::FormBuilder
  delegate :content_tag, :concat, :icon, to: :@template

  def date_picker(method, options = {})
    options[:class] = 'flatpickr flatpickr-input form-control'
    content_tag('div', class: 'form-group') do
      concat(content_tag('div') do
        @template.label(@object_name, method)
      end)
      concat(content_tag('div', class: 'input-group') do
        concat(content_tag('div', class: 'input-group-prepend') do
          content_tag('span', class: 'input-group-text') do
            concat icon('calendar-grid-58', type: :ni)
          end
        end)
        concat @template.text_field(@object_name, method, options)
      end)
    end
  end

  def image_field(method, new_text, change_text, options = {})
    new = options[:new] ||= false
    show_preview = options[:show_preview] ||= false
    id = options[:id] ||= Util::genarate_random_string(25)
    url = options[:value]

    options_input = options.extract!(:onchange, :id)
    options_input[:onchange] = options_input[:onchange].to_s + "setTimeout(() => {
                                    $('##{id}-image').attr('src', $('##{id}-preview > img').attr('src'));
                                 }, 500)"

    content_tag('div', class: 'form-group') do
      concat(content_tag('div') do
        @template.label @object_name, method, @template
      end)
      concat(content_tag('div',
                         class: "fileinput #{new ? 'fileinput-new' : 'fileinput-exists'} text-center",
                         data: { provides: 'fileinput' }) do
        concat(content_tag('div', id: "#{id}-preview",
                           class: "fileinput-preview fileinput-exists thumbnail img-raised #{'d-none' unless show_preview}") do
        end)
        concat(content_tag('span', class: 'btn btn-raised btn-default btn-file') do
          concat(content_tag('span', class: 'fileinput-new') do
            concat(icon('image', margin: 1))
            concat(new_text)
          end)
          concat(content_tag('span', class: 'fileinput-exists') do
            concat(icon('refresh', margin: 1))
            concat(change_text)
          end)
          concat(@template.file_field @object_name, method, options_input)
        end)
        concat(content_tag('span', class: 'fileinput-exists') do
          @template.view_image_button(url, 'title', button_text: '', id: id)
        end)
      end)
    end
  end
end