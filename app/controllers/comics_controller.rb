#+------------------------------------------------------------+
# * File Name         : comics_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class ComicsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_user, :except => [:show, :index, :like, :dislike]
  before_action :set_comic, :only => [:show, :edit, :update, :destroy, :like, :dislike]
  before_action :comic_required_login, :only => [:show]
  before_action :checkage_restriction_on_comic, :only => [:show]
  before_action :require_owner, :only => [:edit, :update, :destroy]
  respond_to :html
  # Inititlize the new book and comic with there cover image
  def new
    @comic = Comic.new
    @book = Book.new
    @comic.build_image
    @book.build_image
  end

  # Create comic with the input parameters by the user
  def create
    @book = Comic.new
    @comic = @user.comics.new(comic_params)
    @image = Image.new(image_params)
    @comic.image = @image
    if @comic.save
      redirect_to user_comics_path(@user)
    else
      render :new
    end
  end

  # Showing the comics created by the user
  def index
    @user = current_user
    @category = params.has_key?(:category) ? params[:category] : "newest-oldest"
    @comics = Kaminari.paginate_array(Search.new.filter_comics_with_category(@user, @category)).page(params[:page]).per(10)
  end

  # Show the comic and there information like comments, replies, like and dislike
  def show
    # We have used the friendly_id that's why need to write like the below to add the views count
    impressionist(@comic, "comics...") 
  end

  # Edit the comic that created by the user previosly
  def edit
  end

  # Update comic data with the updated input parameters by the user
  def update
    @comic.update_comic_cover_picture update_image_params["photo"] unless update_image_params.nil?
    if @comic.errors.empty? && @comic.update_attributes(update_comic_params)
      redirect_to user_comics_path(@user)
    else
      render :edit
    end
  end

  # Delete comic by the user, only created user can delete the same.
  def destroy
    @comic.destroy
    redirect_to :back
  end
  
  # Set the like of the user to given comics as the resources
  def like
    @comic.liked_by current_user
    redirect_to :back, :notice => "Thanks for your vote..."
  end

  # Set the dislike of the user to given comics as the resources
  def dislike
    @comic.disliked_by current_user
    redirect_to :back
  end

  private

  # Permitted parameters
  def comic_params
    params.require(:comic).permit(:title, :description, :url_name, :license_type, :language, :author, :genre, :age_restriction, :login_require, :attachment, :comic_tags, :turn_off_ads, :image_attributes => [:photo])
  end

  # Permitted parameters
  def update_comic_params
    params.require(:comic).permit(:title, :description, :url_name, :license_type, :author, :genre, :age_restriction, :login_require, :attachment, :comic_tags, :turn_off_ads)
  end

  # Permitted parameters
  def image_params
    params[:comic][:image_attributes].permit(:photo) if params[:comic].has_key?(:image_attributes)
  end

  # Permitted parameters
  def update_image_params
    params[:comic][:image_attributes].permit(:photo) if params[:comic][:image_attributes].has_key?(:photo)
  end

  # Set comic before actions that need the same object
  def set_comic
    @comic = Comic.find_by_slug(params[:slug])
  end

  # Set user before actions
  def set_user
    @user = User.find(params[:user_id])
  end
  
  # Check the owner of the book before actions
  def require_owner
    @messsage = "You don't have the permission to do this operation."
    render :file => "shared/message" unless @user.eql?(current_user)
  end
  
  # The owner can set the login required functionality for the book, So the user must have to sign-in for get the book.
  def comic_required_login
    @messsage = "You need to sign-in first to read that comic."
    render :file => "shared/message" if @comic.login_require && current_user.nil?   
  end
  
  # Check the age restriction for the user to view the comic
  def checkage_restriction_on_comic
    @messsage = "Your age criteria not satisfied to view that comic."
    render :file => "shared/message" if current_user && current_user.age_restriction_on_resource(@comic)
  end
end
