class Vote < ActiveRecord::Base
  # vote_id, vote, user_id, votable_id, votable_type
  # -------, ----, set blw, set below-, set below
  
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :votable, polymorphic: true
end