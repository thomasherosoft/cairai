#+------------------------------------------------------------+
# * File Name         : registrations_controller.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class RegistrationsController < Devise::RegistrationsController
  # Inititlize the new book and comic with there cover image
  def new
    super
  end

  # Sign-Up the new user for the application.
  def create
    if verify_recaptcha
      super 
    else
      build_resource(sign_up_params)
      flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
      flash.delete :recaptcha_error
      render :new
    end
  end

  # Account information update method for the user
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource.update_profile_picture(params[:user][:photo]) if params[:user].has_key?(:photo)
    resource_updated = update_resource(resource, account_update_params) if resource.errors.empty?
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
end
