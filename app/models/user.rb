class User < ActiveRecord::Base
   include Sluggable
   
   has_many :posts
   has_many :comments
   has_many :votes
   has_secure_password validations: false
   validates_presence_of :password, :on => :create, length: { minimum: 5 }
   validates_uniqueness_of :username
   
   # set the property that will be sluggified
   def slug_string 
      self.username
   end
end