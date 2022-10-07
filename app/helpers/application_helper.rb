module ApplicationHelper
  # Return full title on basic title page
  def full_title(page_title = '')
    base_title = "Ruby on Rails Tutorial Sample App"
      return base_title if page_title.empty?
      return page_title + " | " + base_title if !page_title.empty?
  end
end
