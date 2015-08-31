#+------------------------------------------------------------+
# * File Name         : bookmarks_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_resource, :only => [:update]
  #before_action :book_required_login, :only => [:show]
  def new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.save
    flash[:notice] = "Page has been successfully bookmarked for you."
    redirect_to :back
  end
  
  def update
    @bookmark = Bookmark.bookmark_available(@user, @resource)
    @bookmark.update_attributes(bookmark_params)
    flash[:notice] = "Page bookmarked has been successfully updated for you."
    redirect_to :back
  end
  
  private

  # Permitted parameters
  def bookmark_params
    params.require(:bookmark).permit(:bookmarkable_id, :bookmarkable_type, :user_id, :page_number)
  end
  
  # Set book before actions that need the same object
  def set_resource
    if params[:bookmark][:bookmarkable_type].eql?("Book")
      @resource = Book.find_by_id(params[:bookmark][:bookmarkable_id])
    else
      @resource = Comic.find_by_id(params[:bookmark][:bookmarkable_id])
    end  
  end

  # Set user before actions
  def set_user
    @user = User.find(params[:bookmark][:user_id])
  end

end
