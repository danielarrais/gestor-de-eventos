module LayoutHelper
  def page_title(title)
    content_tag('div', class: 'ct-page-title') do
      concat content_tag('h1', title, class: 'ct-title')
    end.html_safe
  end

  def icon_link(text, icon, path)
    content_tag('div', class: 'float-right pt-4') do
      concat(link_to("<span><i class='fa fa-#{icon}'></i> #{text}</span>".html_safe, path))
    end
  end
end
