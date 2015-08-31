#+------------------------------------------------------------+
# * File Name         : song.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class Song < ActiveRecord::Base
  acts_as_commentable
  paginates_per 3
  validates :title, :presence => { :message => "Please enter song title, can't be blank" }
  validates :description, :presence => { :message => "Please enter song description, can't be blank" }

  belongs_to :user
end
