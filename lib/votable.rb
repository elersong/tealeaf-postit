module Votable
  extend ActiveSupport::Concern # Difference between instance methods and class methods
  
  included do # code to be executed once... like association declarations
    has_many :votes, as: :votable # declare the 1 side of the 1:M(polymorphic) association
  end
  
  def vote_score
      upvotes - downvotes
  end
  
  #if I wanted to put in class methods
  # module ClassMethods
  #   def testing
  #     puts "testing"
  #   end
  # end
  
  private
  
  def upvotes
    Vote.where(vote: true, votable_type: self.class, votable_id: self.id).count
  end
 
  def downvotes
    Vote.where(vote: false, votable_type: self.class, votable_id: self.id).count
  end

end