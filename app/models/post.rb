class Post < ActiveRecord::Base
   include Votable
   include Sluggable
   
   has_many :comments
   has_many :post_categories
   has_many :categories, through: :post_categories
   belongs_to :creator, foreign_key: "user_id", class_name: "User"
   
   validates_presence_of :title
   validates_uniqueness_of :title
   validates_presence_of :description
   
   def slug_string # set the property that will be sluggified
      self.title
   end
   
end