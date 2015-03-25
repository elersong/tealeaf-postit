module TimeZonable
  extend ActiveSupport::Concern
  
  def created_at
    self.created_at.in_time_zone(self.time_zone)
  end
  
  def updated_at
    self.updated_at.in_time_zone(self.time_zone)
  end
  
end