#+------------------------------------------------------------+
# * File Name         : votes_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource
  respond_to :js
  
  # Set the like of the user to given comments as the resources
  # Will not add again vote, If user has alreay given on the same
  # If user has added like vote and If going to add the dislike for the same then like vote will be count nothing 
  def like
    @comment.liked_by current_user
  end

  # Set the dislike of the user to given comments as the resources
  # Will not add again vote, If user has alreay given on the same
  # If user has added dislike vote and If going to add the like for the same then dislike vote will be count nothing
  def dislike
    @comment.disliked_by current_user
  end
  
  private
  
  # Set the voteable resources first then add the vote of the user
  def set_resource
    @comment = Comment.find(params[:id])
    @resource = @comment.commentable
  end

end
