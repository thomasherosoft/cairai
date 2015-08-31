#+------------------------------------------------------------+
# * File Name         : application_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # Permitted parameters for the sign-in, sign-up and accont updates process of the user
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :username, :first_name, :last_name, :birthday, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :first_name, :last_name, :age, :country_code, :language_first, :language_second, :sex, :address, :birthday, :password, :password_confirmation, :current_password) }
  end
end
