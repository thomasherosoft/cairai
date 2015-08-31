#+------------------------------------------------------------+
# * File Name         : comic.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class Comic < ActiveRecord::Base
  acts_as_commentable
  is_impressionable
  paginates_per 3
  extend FriendlyId
  friendly_id :url_name, use: :slugged
  
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comics.
  acts_as_votable
  
  validates :title, :presence => { :message => "Please enter comic title, can't be blank" }
  validates :description, :presence => { :message => "Please enter comic description, can't be blank" }
  validates :url_name, :presence => { :message => "Please enter proper url name, can't be blank and should be uniqe" }, :uniqueness => true, :length => { :maximum => 100 }
  validates :license_type, :presence => { :message => "Please select license type, can't be blank" }
  validates :genre, :presence => { :message => "Please select book content type, can't be blank" }
  validates :age_restriction, :presence => { :message => "Please enter comic age restrictions, can't be blank" }
  validates :author, :presence => { :message => "Please enter comic author name, can't be blank" }
  validates :language, :presence => { :message => "Please enter comic language, can't be blank" }
  validates :attachment, :attachment_presence => true
  has_attached_file :attachment,
                    :url => "/system/comics/:id/:style/:basename.:extension",
                    :default_url => "/system/default/:style/missing.png",
                    :path => ":rails_root/public/system/comics/:id/:style/:basename.:extension",
                    :size => { :in => 0.megabytes..5.megabytes }

  validates_attachment_content_type :attachment, :content_type => "application/pdf", :message => "Invalid file format, Allow only pdf files."

  belongs_to :user
  has_one :image, as: :imageable
  has_many :bookmarks, as: :bookmarkable, :dependent => :destroy
  accepts_nested_attributes_for :image
  attr_accessor :photo, :image_attribute, :comic_tags
  
  # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :comic_tags
  
  before_save :set_comic_tags
  
  # Comic cover photo
  def comic_cover
    self.image
  end
  
  def bookmark_by user
    Bookmark.bookmark_available(user.id, self) ? true :false
  end
  
  def set_comic_tags
    self.comic_tag_list.add(self.comic_tags, parse: true)
  end
  
  # Update the cover photo for the comic
  def update_comic_cover_picture photo
    if valid_extension?(File.extname(photo.original_filename))
      self.image.update_attributes(:photo => photo)
    else
      self.errors.add(:photo, "Invalid profile picture format, Allow only(jpg,jpeg,png) images.")
    end
  end

  # Validation for the cover photo of the comic cover
  def valid_extension?(filename_extname)
    %w( .jpg .jpeg .png ).include? filename_extname.downcase
  end
  
  # Get the up votes for the comic
  def get_up_comment_votes
    vote = 0
    comment_threads.each{ |comment| vote += comment.get_up_votes.size }
    vote
  end
  
  # Get the down votes for the comic
  def get_down_comment_votes
    vote = 0
    comment_threads.each{ |comment| vote += comment.get_down_votes.size }
    vote
  end
  
  # Arrange the comics with up votes or most likes
  def self.sort_by_highest_liked_comics(user)
   comic_voted_array = Array.new  
   user.comics.includes(:comment_threads).each{ |comic| comic_voted_array.push({ :comic => comic, :like => comic.get_ups }) }
   comic_voted_array.sort_by {|h| h[:like] }.map{|h| h[:comic]}.reverse
  end
  
  # Arrange the comics with up votes or most dislikes
  def self.sort_by_highest_disliked_comics(user)
   comic_voted_array = Array.new  
   user.comics.includes(:comment_threads).each{ |comic| comic_voted_array.push({ :comic => comic, :dislike => comic.get_downs }) }
   comic_voted_array.sort_by {|h| h[:dislike] }.map{|h| h[:comic]}.reverse
  end
  
  def filtered_views_based_on_sex
    unique_user_ids = self.user_views
    return { :male => User.filter_sex_users(unique_user_ids, 'male').count, :female => User.filter_sex_users(unique_user_ids, 'female').count, :androgyne => User.filter_sex_users(unique_user_ids, 'androgyne').count }
  end
  
   def total_views_count
    self.impressionist_count
  end
  
  def user_views
    self.impressions.select(:user_id).distinct.pluck(:user_id)
  end
  
  def unique_views_count
    self.impressions.select(:user_id).distinct.where("date(created_at) >= ? AND date(created_at) <= ?",(DateTime.now-24.hours), DateTime.now).count
  end

end
