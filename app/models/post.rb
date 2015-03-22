class Post < ActiveRecord::Base
   has_many :comments
   has_many :votes, as: :votable # declare the 1 side of the 1:M(polymorphic) association
   has_many :post_categories
   has_many :categories, through: :post_categories
   belongs_to :creator, foreign_key: "user_id", class_name: "User"
   validates_presence_of :title
   validates_presence_of :description
   
   def vote_score
      upvotes - downvotes
   end
   
   private
   
   def upvotes
      Vote.where(vote: true, votable_type: self.class, votable_id: self.id).count
   end
   
   def downvotes
      Vote.where(vote: false, votable_type: self.class, votable_id: self.id).count
   end
end