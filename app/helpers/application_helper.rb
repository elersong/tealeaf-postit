module ApplicationHelper
  
  def format_and_link(string)
    url = string.include?("http://") ? string : string.include?("https://") ? string : "http://#{string}"
    link_to url.to_s, url
  end
  
  def to_human(timestamp)
    timestamp.strftime("%b %d, %Y")
  end
  
end
