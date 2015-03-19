module ApplicationHelper
  
  def format_and_link(string)
    url = string.include?("http://") ? string : string.include?("https://") ? string : "http://#{string}"
    link_to url.to_s, url
  end
  
  def to_human(timestamp)
    timestamp.strftime("%b %d, %Y")
  end
  
  def current_user?
    !!current_user
  end
  
  def current_user
    if session[:user_id] != nil
      @logged_in_user ||= User.find(session[:user_id])
    else
      nil
    end
  end
  
end
