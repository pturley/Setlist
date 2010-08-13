# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def title
    base_title = "Setlist"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h(@title)}"
    end
  end
  
  def logo
    image = image_tag "logo.png", :alt => "Setlist", :class => "logo round"
    link_to image, root_path
  end
end
