#+------------------------------------------------------------+
# * File Name         : book.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class Book < ActiveRecord::Base
  acts_as_commentable
  is_impressionable
  paginates_per 3
  extend FriendlyId
  friendly_id :url_name, use: :slugged
  
  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of books.
  acts_as_votable
  
  validates :title, :presence => { :message => "Please enter book title, can't be blank" }
  validates :description, :presence => { :message => "Please enter book description, can't be blank" }
  validates :url_name, :presence => { :message => "Please enter proper url name, can't be blank and should be uniqe" }, :uniqueness => true, :length => { :maximum => 100 }
  validates :license_type, :presence => { :message => "Please select license type, can't be blank" }
  validates :genre, :presence => { :message => "Please select book content type, can't be blank" }
  validates :age_restriction, :presence => { :message => "Please enter book age restrictions, can't be blank" }
  validates :author, :presence => { :message => "Please enter comic author name, can't be blank" }
  validates :language, :presence => { :message => "Please enter comic language, can't be blank" }
  validates :attachment, :attachment_presence => true
  has_attached_file :attachment,
                    :url => "/system/books/:id/:style/:basename.:extension",
                    :default_url => "/system/default/:style/missing.png",
                    :path => ":rails_root/public/system/books/:id/:style/:basename.:extension",
                    :size => { :in => 0.megabytes..5.megabytes }

  validates_attachment_content_type :attachment, :content_type => "application/pdf", :message => "Invalid file format, Allow only pdf files."

  belongs_to :user
  has_one :image, as: :imageable, :dependent => :destroy
  has_many :bookmarks, as: :bookmarkable, :dependent => :destroy
  accepts_nested_attributes_for :image
  attr_accessor :photo, :image_attribute, :book_tags
  
  #acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :book_tags
  
  before_save :set_book_tags
  
  # Book cover photo
  def book_cover
    self.image
  end
  
  def bookmark_by user
    Bookmark.bookmark_available(user.id, self) ? true :false
  end
  
  def set_book_tags
    self.book_tag_list.add(self.book_tags, parse: true)
  end

  # Update the cover photo for the book
  def update_book_cover_picture photo
    if valid_extension?(File.extname(photo.original_filename))
      self.image.update_attributes(:photo => photo)
    else
      self.errors.add(:photo, "Invalid profile picture format, Allow only(jpg,jpeg,png) images.")
    end
  end

  # Validation for the cover photo of the book cover
  def valid_extension?(filename_extname)
    %w( .jpg .jpeg .png ).include? filename_extname.downcase
  end
  
  # Get the up votes for the book
  def get_up_comment_votes
    vote = 0
    comment_threads.each{ |comment| vote += comment.get_up_votes.size }
    vote
  end
  
  # Get the down votes for the book
  def get_down_comment_votes
    vote = 0
    comment_threads.each{ |comment| vote += comment.get_down_votes.size }
    vote
  end
  
  # Arrange the books with up votes or most likes
  def self.sort_by_highest_liked_books(user)
   book_voted_array = Array.new  
   user.books.includes(:comment_threads).each{ |book| book_voted_array.push({ :book => book, :like => book.get_ups.count }) }
   book_voted_array.sort_by {|h| h[:like] }.map{|h| h[:book]}.reverse
  end
  
  # Arrange the books with up votes or most dislikes
  def self.sort_by_highest_disliked_books(user)
   book_voted_array = Array.new  
   user.books.includes(:comment_threads).each{ |book| book_voted_array.push({ :book => book, :dislike => book.get_downs }) }
   book_voted_array.sort_by {|h| h[:dislike] }.map{|h| h[:book]}.reverse
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
    self.impressions.select(:user_id).distinct.where("date(created_at) >= ? AND date(created_at) <= ?",(DateTime.now - 24.hours), DateTime.now).count
  end


end
