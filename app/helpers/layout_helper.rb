module LayoutHelper
  def view_image_button(url, title, button_text: '', id: Util::genarate_random_string(25))
    url ||= url_image_fake(text: 'IMAGEM NÃO ENCONTRADA', resolution: '500x500')

    content = content_tag :label, data: { toggle: 'tooltip', placement: 'bottom' }, title: "Visualizar Imagem" do
      link_to "<span><i class='fa fa-search #{'mr-1' unless button_text.blank?}'></i>#{button_text}</span>".html_safe, '#',
              class: 'btn btn-default btn-icon btn-1 btn-simple', data: { toggle: "modal", target: "##{id}-modal" }
    end

    content << modal(id, title, size: :lg) do
      concat(modal_body do
        content_tag(:div, class: 'text-center') do
          image_tag url, style: 'max-height: 500px; max-width: 750px;', id: "#{id}-image"
        end
      end)
    end
  end

  def pdf_javascript_pack_tag(name)
    javascript_include_tag(Rails.public_path.to_s + sources_from_manifest_entries([name], type: :javascript)[0])
  end


  def modal(id, title, options = nil, &block)
    close = options[:close] || true
    size = options[:size] || :default
    keyboard = options[:outside_click] || false
    backdrop = keyboard ? true : 'static'

    content_tag(:div, id: "#{id}-modal", class: 'modal fade',
                tabindex: '-1', role: 'dialog', data: { backdrop: "#{backdrop}", keyboard: "#{keyboard}" },
                'aria-labelledby' => "#{id}-label",
                'aria-hidden' => "true") do
      content_tag :div, class: "modal-dialog modal-dialog-centered modal-#{size}", role: 'document' do
        content_tag :div, class: 'modal-content' do
          concat(content_tag(:div, class: 'modal-header') do
            concat(content_tag(:h5, class: 'modal-title', id: "#{id}-label") do
              title
            end)
            concat(button_tag('', { class: "close", 'data-dismiss' => "modal", 'aria-label' => "Close" }) do
              content_tag(:span, 'aria-hidden' => 'true') do
                '&times;'.html_safe
              end
            end) if close
          end)
          concat(capture(&block))
        end
      end
    end
  end

  def modal_body(&block)
    content_tag(:div, class: 'modal-body mt-0') do
      capture(&block)
    end
  end

  def modal_footer(&block)
    content_tag(:div, class: 'modal-footer') do
      capture(&block)
    end
  end

  def page_title(title)
    content_tag 'div', class: 'ct-page-title' do
      content_tag 'h1', title, class: 'ct-title mt-0'
    end
  end

  def icon_link(text, icon, path, options = nil)
    link_to span_icon(text, icon, margin: 2).html_safe, path, options
  end

  def card_filter(id = 'collapseFilter', &block)
    content_tag('div', class: 'row') do
      content_tag('div', class: 'col') do
        content_tag('div', class: 'collapse', id: 'collapseFilter') do
          content_tag('div', class: 'card bg-secondary card-body shadow-none') do
            capture(&block)
          end
        end
      end
    end
  end

  def span_icon(text, icon, margin: 0)
    margin = 2 if margin == 0 && !text.blank?
    content_tag 'span' do
      concat icon icon, margin: margin
      concat text
    end
  end

  def icon(icon, type: :fa, margin: 0)
    content_tag('i', class: "#{type} #{type}-#{icon} mr-#{margin}") do
    end
  end
end
