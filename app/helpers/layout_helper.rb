module LayoutHelper
  def view_image_button(url, title, button_text: '', id: Util::genarate_random_string(25))
    url = url ||= url_image_fake(text: 'IMAGEM NÃO ENCONTRADA', resolution: '500x500')

    @content = link_to "<span><i class='fa fa-search #{'mr-1' unless button_text.blank?}'></i>#{button_text}</span>".html_safe, '#',
                       class: 'btn btn-default btn-icon btn-1 btn-simple', data: { toggle: "modal", target: "##{id}-modal" }

    @content << content_tag(:div, id: "#{id}-modal", class: 'modal fade',
                            tabindex: '-1', role: 'dialog',
                            'aria-labelledby' => "#{id}_label",
                            'aria-hidden' => "true") do
      content_tag :div, class: 'modal-dialog modal-dialog-centered modal-lg', role: 'document' do
        content_tag :div, class: 'modal-content' do
          concat(content_tag(:div, class: 'modal-header') do
            concat(content_tag(:h5, class: 'modal-title', id: "#{id}_label") do
              title
            end)
            concat(button_tag('', { class: "close", 'data-dismiss' => "modal", 'aria-label' => "Close" }) do
              content_tag(:span, 'aria-hidden' => 'true') do
                '&times;'.html_safe
              end
            end)
          end)
          concat(content_tag(:div, class: 'modal-body') do
            content_tag(:div, class: 'text-center') do
              image_tag url, style: 'max-height: 500px; max-width: 750px;', id: "#{id}-image"
            end
          end)
        end
      end
    end
  end

  def page_title(title)
    content_tag 'div', class: 'ct-page-title' do
      content_tag 'h1', title, class: 'ct-title mt-0'
    end
  end

  def icon_link(text, icon, path)
    link_to span_icon(text, icon).html_safe, path
  end

  def span_icon(text, icon)
    margin = text.blank? ? 0 : 1
    
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
