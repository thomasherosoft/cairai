#+------------------------------------------------------------+
# * File Name         : books_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class BooksController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_user, :except => [:show, :index, :like, :dislike]
  before_action :set_book, :only => [:show, :edit, :update, :destroy, :like, :dislike]
  before_action :book_required_login, :only => [:show]
  before_action :checkage_restriction_on_book, :only => [:show]
  before_action :require_owner, :only => [:edit, :update, :destroy]
  respond_to :html
  # Inititlize the new book and comic with there cover image
  def new
    @book = Book.new
    @comic = Comic.new
    @book.build_image
    @comic.build_image
  end

  # Create book with the input parameters by the user
  def create
    @comic = Comic.new
    @book = @user.books.new(book_params)
    @image = Image.new(image_params)
    @book.image = @image
    if @book.save
      redirect_to user_books_path(@user)
    else
      render :new
    end
  end

  # Showing the books created by the user
  def index
    @user = current_user
    @category = params.has_key?(:category) ? params[:category] : "newest-oldest"
    @books = Kaminari.paginate_array(Search.new.filter_books_with_category(@user, @category)).page(params[:page]).per(10)
  end

  # Show the book and there information like comments, replies, like and dislike
  def show
    # We have used the friendly_id that's why need to write like the below to add the views count
    impressionist(@book, "books...")
  end

  # Edit the book that created by the user previosly
  def edit
  end

  # Update book data with the updated input parameters by the user
  def update
    @book.update_book_cover_picture update_image_params["photo"] unless update_image_params.nil?
    if @book.errors.empty? && @book.update_attributes(update_book_params)
      redirect_to user_books_path(@user)
    else
      render :edit
    end
  end

  # Delete book by the user, only created user can delete the same.
  def destroy
    @book.destroy
    redirect_to :back
  end
  
  # Set the like of the user to given books as the resources
  def like
    @book.liked_by current_user
    redirect_to :back, :notice => "Thanks for your vote..."
  end

  # Set the dislike of the user to given books as the resources
  def dislike
    @book.disliked_by current_user
    redirect_to :back
  end
  
  private

  # Permitted parameters
  def book_params
    params.require(:book).permit(:title, :description, :url_name, :license_type, :language, :author, :genre, :age_restriction, :login_require, :attachment, :book_tags, :turn_off_ads, :image_attributes => [:photo])
  end

  # Permitted parameters
  def update_book_params
    params.require(:book).permit(:title, :description, :url_name, :license_type, :author, :genre, :age_restriction, :login_require, :attachment, :book_tags, :turn_off_ads)
  end

  # Permitted parameters
  def image_params
    params[:book][:image_attributes].permit(:photo) if params[:book].has_key?(:image_attributes)
  end

  # Permitted parameters
  def update_image_params
    params[:book][:image_attributes].permit(:photo) if params[:book][:image_attributes].has_key?(:photo)
  end

  # Set book before actions that need the same object
  def set_book
    @book = Book.find_by_slug(params[:slug])
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
  def book_required_login
    @messsage = "You need to sign-in first to read that book."
    render :file => "shared/message"  if @book.login_require && current_user.nil?   
  end
  
  # Check the age restriction for the user to view the book
  def checkage_restriction_on_book
    @messsage = "Your age criteria not satisfied to view that book."
    render :file => "shared/message" if current_user && current_user.age_restriction_on_resource(@book)
  end
end
