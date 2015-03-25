class User < ActiveRecord::Base
   include Sluggable
   include TimeZonable
   
   has_many :posts
   has_many :comments
   has_many :votes
   has_secure_password validations: false
   validates_presence_of :password, :on => :create, length: { minimum: 5 }
   validates_uniqueness_of :username
   
   before_create :set_role
   
   # set the property that will be sluggified
   def slug_string 
      self.username
   end
   
   def admin?
      self.role == "admin"   
   end
   
   def set_role
      self.role = "user" if self.role == nil
   end
   
end