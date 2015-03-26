module ApplicationHelper
  
  def format_and_link(string)
    url = string.include?("http://") ? string : string.include?("https://") ? string : "http://#{string}"
    link_to url.to_s, url
  end
  
  def to_human(timestamp)
    timestamp.in_time_zone(current_user.time_zone).strftime("%b %d, %Y")
  end
  
  def current_user?
    !!current_user
  end
  
  def admin?
    return false if current_user.nil?
    current_user.role == "admin"
  end
  
  def current_user
    if session[:user_id] != nil
      @logged_in_user ||= User.find(session[:user_id])
    else
      nil
    end
  end
  
  def profile_page?
    session[:profile_page] == true ? true : false
  end
  
end
