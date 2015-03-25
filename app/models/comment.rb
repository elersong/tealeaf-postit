class Comment < ActiveRecord::Base
   include Votable
   include TimeZonable
   
   belongs_to :creator, foreign_key: "user_id", class_name: "User"
   belongs_to :post
   
   validates :body, presence: true, uniqueness: true
   
end