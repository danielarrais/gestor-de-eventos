class CertEventsFormBuilder < ActionView::Helpers::FormBuilder
  def initialize(object_name, object, template, options)
    super
    @object_class_name = object.class.to_s.underscore
  end

  delegate :content_tag, :concat, :icon, :add_class, to: :@template

  def label(method, text = nil, options = {}, &block)
    if @object_name.to_s.include? '['
      i18n_key = "activerecord.attributes.#{@object_name}/#{method}".remove(/\[[0-9]\]/, '_attributes', ']').gsub('[', '.')
      text = I18n.translate(i18n_key, default: nil)
    end

    @template.label(@object_name, method, text, objectify_options(options), &block)
  end

  # Usa placeholders para inserir uma opção em branco no select
  def select(method, choices = nil, options = {}, html_options = {})
    if options[:include_blank] == true
      i18n_key = "helpers.placeholder.#{@object_class_name}.#{method}"
      options[:include_blank] = I18n.translate(i18n_key, default: "")
    end
    super method, choices, options, html_options
  end

  def summernote_area(method, options = {})
    options[:rows] = options[:rows] || 20
    add_class options, 'summernote'

    text_area method, options
  end

  def date_picker(method, options = {})
    options[:value] = @object[method.to_sym].to_time.iso8601 if @object.present? && @object[method.to_sym].present?

    add_class options, 'flatpickr flatpickr-input form-control'

    content_tag('div', class: 'form-group') do
      concat(content_tag('div') do
        label(method) unless options[:hide_label]
      end)
      concat(content_tag('div', class: 'input-group') do
        concat(content_tag('div', class: 'input-group-prepend') do
          content_tag('span', class: 'input-group-text') do
            concat icon('calendar-grid-58', type: :ni)
          end
        end)
        concat text_field(method, options)
      end)
    end
  end

  def date_time_picker(method, options = {})
    date_picker method, options.merge(class: 'datetimepicker')
  end

  def image_field(method, new_text, change_text, options = {})
    new = options[:value].nil?
    show_preview = options[:show_preview] ||= false
    id = options[:id] ||= Util::genarate_random_string(25)
    url = options[:value]

    options_input = options.extract!(:onchange, :id)
    options_input[:onchange] = options_input[:onchange].to_s + "setTimeout(() => {
                                    $('##{id}-image').attr('src', $('##{id}-preview > img').attr('src'));
                                 }, 500)"

    content_tag('div', class: 'form-group') do
      concat(content_tag('div') do
        label method
      end) unless options[:hide_label]
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
          concat(file_field method, options_input)
        end)
        concat(content_tag('span', class: 'fileinput-exists') do
          @template.view_image_button(url, @template.i18n_model(@object_class_name, method), button_text: '', id: id)
        end)
      end)
    end
  end
end