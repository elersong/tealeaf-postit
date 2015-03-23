class User < ActiveRecord::Base
   has_many :posts
   has_many :comments
   has_many :votes
   has_secure_password validations: false
   validates_presence_of :password, :on => :create, length: { minimum: 5 }
   validates_uniqueness_of :username
   
   before_create :generate_slug
   
   # 1) Allow numbers. 2) Only one space. 3) No punctuation. 4) Replace spaces with dashes
   def generate_slug
      self.slug = self.username.gsub(/\s{2,}/," ").gsub(" ","_").gsub(/(\d)\W/,"").gsub("_","-").downcase
   end
   
   # Set slug as the path for path helper methods in the views
   def to_param
      self.slug
   end
   
end