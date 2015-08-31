#+------------------------------------------------------------+
# * File Name         : application_mailer.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'
end
