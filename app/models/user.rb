class User < ActiveRecord::Base
   has_many :posts
   has_many :comments
   has_secure_password validations: false
   validates_presence_of :password, :on => :create, length: { minimum: 5 }
   validates_uniqueness_of :username
end