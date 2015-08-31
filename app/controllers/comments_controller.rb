#+------------------------------------------------------------+
# * File Name         : comics_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_resource, :except => [:destroy]
  before_action :set_parent, :except => [:destroy]
  before_action :set_comment, :only => [:update, :destroy]
  respond_to :js
  
  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      @comment.move_to_child_of(@parent) unless @parent.nil?
    end
    respond_with @comment, @resource
  end
  
  def update
    @comment.update_attributes(comment_params)
    respond_with @comment, @resource
  end
  
  def destroy
    @resource = @comment.commentable
    @comment.destroy
    respond_with @resource
  end
   
  private

  # Permitted parameters
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type, :parent_id)
  end 
  
  # Set the parent resource for the comments and replies
  def set_resource
    if params[:comment][:commentable_type].eql?("Book")
      @resource = Book.find(params[:comment][:commentable_id])
    else
      @resource = Comic.find(params[:comment][:commentable_id]) 
    end
  end
  
  # Set the parent for the comments to make then as the child of the parent
  def set_parent
    @parent = params[:comment].has_key?(:parent_id) ? Comment.find(params[:comment][:parent_id]) : nil
  end
  
  def set_comment
    @comment = Comment.find(params[:id])
  end
  
end
