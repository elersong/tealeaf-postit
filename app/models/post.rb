class Post < ActiveRecord::Base
   has_many :comments
   belongs_to :creator, foreign_key: "user_id", class_name: "User"
   has_many :post_categories
   has_many :categories, through: :post_categories
   validates_presence_of :title
   validates_presence_of :description
end