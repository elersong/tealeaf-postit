class Category < ActiveRecord::Base
   has_many :post_categories
   has_many :posts, through: :post_categories
   validates_presence_of :name
   validates :name, length: {minimum: 5}, uniqueness: true
   
   before_create :generate_slug
   
   # 1) Allow numbers. 2) Only one space. 3) No punctuation. 4) Replace spaces with dashes
   def generate_slug
      self.slug = self.name.gsub(/\s{2,}/," ").gsub(" ","_").gsub(/(\d)\W/,"").gsub("_","-").downcase
   end
   
   # Set slug as the path for path helper methods in the views
   def to_param
      self.slug
   end
end