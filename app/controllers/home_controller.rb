#+------------------------------------------------------------+
# * File Name         : home_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class HomeController < ApplicationController
  # Root page of the application with all the available books and comics
  def index
    @books = Book.order(:cached_votes_up => :desc).page params[:page]
    @comics = Comic.order(:cached_votes_up => :desc).page params[:page]
  end
  
  def feed
    @search_result = Kaminari.paginate_array(Search.new.feed_contents(params[:user_id])).page(params[:page]).per(10)
  end

  # Load more books as asynchronously via AJAX
  def load_more_books
    @books = Book.order(:cached_votes_up => :desc).page params[:page]
    respond_to do |format|
      format.js
    end
  end

  # Load more comics as asynchronously via AJAX
  def load_more_comics
    @comics = Comic.order(:cached_votes_up => :desc).page params[:page]
    respond_to do |format|
      format.js
    end
  end

  # Search the books, comics, and both via title as the search text
  def search
    @search_result = Kaminari.paginate_array(Search.new.search_books_and_comics(search_params)).page(params[:page]).per(10)
  end

  private

  # Permitted parameters
  def search_params
    params.require(:search).permit(:search_text, :type)
  end

end
