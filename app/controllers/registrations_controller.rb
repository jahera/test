class RegistrationsController < Devise::RegistrationsController
  
  def new
    super
  end
  
  def create
    build_resource(sign_up_params)
    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      resource.update_attributes(:unhashed_password => resource_params[:password])
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)                
#        UserMailer.notification_for_term_condition(resource).deliver
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end
  
  protected

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end
end
