module LayoutHelper
  def page_title(title)
    content_tag'div', class: 'ct-page-title' do
      concat content_tag'h1', title, class: 'ct-title'
    end
  end

  def icon_link(text, icon, path)
    span_icon = content_tag 'span' do
      concat icon icon, 1
      concat text
    end

    link_to span_icon.html_safe, path
  end

  def icon(icon, margin = 0)
    content_tag('i', class: "fa fa-#{icon} mr-#{margin}") do end
  end
end
