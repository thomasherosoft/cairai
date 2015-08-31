#+------------------------------------------------------------+
# * File Name         : application_helper.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
module ApplicationHelper
  
  # Used to apply ".active" class
  def current_path(path)
    true if current_page?(path)
  end
  
  # Used to apply ".active" class
  def current_controller(cntrl)
   true if controller.controller_name.eql?(cntrl)
  end
 
   # Used to apply ".open" class
  def current_menu(cntrl)
   true if controller.controller_name.eql?(cntrl)
  end
  
end
