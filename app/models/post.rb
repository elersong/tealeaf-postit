class Post < ActiveRecord::Base
   has_many :comments
   has_many :votes, as: :votable # declare the 1 side of the 1:M(polymorphic) association
   has_many :post_categories
   has_many :categories, through: :post_categories
   belongs_to :creator, foreign_key: "user_id", class_name: "User"
   
   validates_presence_of :title
   validates_uniqueness_of :title
   validates_presence_of :description
   
   before_save :generate_slug # to make sure that all posts have a slug, since a title is required
   before_validation :fwdslash_substitution
   
   def vote_score
      upvotes - downvotes
   end
   
   # 1) Allow numbers. 2) Only one space. 3) No punctuation. 4) Replace spaces with dashes
   def generate_slug
      self.slug = self.title.gsub(/\s{2,}/," ").gsub(" ","_").gsub(/(\d)\W/,"").gsub("_","-").downcase
   end
   
   # Set slug as the path for path helper methods in the views
   def to_param
      self.slug
   end
   
   # ensure there are no slashes in the title before slug generation
   def fwdslash_substitution 
      self.title = self.title.gsub("/","-").gsub("\\","-")
   end
   
   private
   
   def upvotes
      Vote.where(vote: true, votable_type: self.class, votable_id: self.id).count
   end
   
   def downvotes
      Vote.where(vote: false, votable_type: self.class, votable_id: self.id).count
   end
   
end