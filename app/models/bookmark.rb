#+------------------------------------------------------------+
# * File Name         : bookmark.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class Bookmark < ActiveRecord::Base
  belongs_to :bookmarkable, polymorphic: true
  
  validates :user_id, :presence => true
  
  def self.bookmark_available(user_id, obj)
    self.where(:user_id => user_id, :bookmarkable_id => obj.id, :bookmarkable_type => obj.class.name).first
  end
  
  def self.add_bookmark
    
  end
  
  def self.update_bookmark
    
  end
  
  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, page_number)
    new \
      :bookmarkable => obj,
      :page_number  => page_number,
      :user_id     => user_id
  end
  
  # Helper class method to lookup all bookmarks created
  # to all bookmarkable types for a given user.
  scope :find_bookmarks_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }
  
  # Helper class method to look up a bookmarkable object
  # given the bookmarkable class name and id
  def self.find_bookmarkable(bookmarkable_str, bookmarkable_id)
    bookmarkable_str.constantize.find(bookmarkable_id)
  end
end
