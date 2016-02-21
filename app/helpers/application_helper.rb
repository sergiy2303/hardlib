module ApplicationHelper
  def navbar_link_to(label, url, options = {})
    content_tag(:li, class: request.path.start_with?(url) ? 'active' : '') do
      link_to(label, url, options)
    end
  end
end
