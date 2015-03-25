module Sluggable
  # ========================================================================================
  # In order to use this module, there needs to be a "slug" column in the db table.
  # There also needs to be a "slug_string" method that returns the value to be slugged.
  # If there are special validations for some not others, use the include block.
  # ========================================================================================
  
  extend ActiveSupport::Concern # allow simpler, non-metaprogramming syntax
  
  # code to be run once when module is included
  included do |klass| # klass is the class that is including this Sluggable module
    before_create :generate_slug # to make sure that all posts have a slug, since a title is required
    
    if klass.to_s == "Post"
      klass.before_validation :fwdslash_substitution 
    end
    
  end
 
  # 1) Allow numbers. 2) Only one space. 3) No punctuation. 4) Replace spaces with dashes
  def generate_slug
    self.slug = slug_string.gsub(/\s{2,}/," ").gsub(" ","_").gsub(/(\d)\W/,"").gsub("_","-").downcase
  end
  
  # Set slug as the path for path helper methods in the views
  def to_param
    self.slug
  end
  
  # ensure there are no slashes in the title before slug generation
  def fwdslash_substitution 
    self.title = self.title.gsub("/","-").gsub("\\","-")
  end
   
  # # class method definitions
  # module ClassMethods
  #   ...
  # end
  
end