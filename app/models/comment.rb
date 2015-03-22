class Comment < ActiveRecord::Base
   belongs_to :creator, foreign_key: "user_id", class_name: "User"
   belongs_to :post
   has_many :votes, as: :votable # declare the 1 side of the 1:M(polymorphic) association
   
   validates :body, presence: true, uniqueness: true
   
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