module ApplicationHelper
  def page_title
    title = 'Baseball CMS'
    title = @page_title + ' - ' + title if @page_title
    title
  end

  def menu_link_to(text, path, options = {})
    tag.li do
      condition = options[:method] || !current_page?(path)

      link_to_if(condition, text, path, options) do
        tag.span(text)
      end
    end
  end
end
