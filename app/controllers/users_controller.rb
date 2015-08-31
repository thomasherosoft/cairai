#+------------------------------------------------------------+
# * File Name         : users_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class UsersController < ApplicationController
  before_action :authenticate_user!
  # Show the current user profile to the profile user
  def profile
    @profile = current_user
  end
end
