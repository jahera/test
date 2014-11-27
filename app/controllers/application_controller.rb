class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_devise_params, if: :devise_controller?
    #before_filter :read_and_parse_json_file_params

    # def read_and_parse_json_file_params
    #   p "sssssssssssssssssssssssssss"
    #   file_params = params.select { |name,value| value.is_a?(File) || value.is_a?(Tempfile) }
    #   file_params.reject! { |name,file| file.content_type !~ %r{^application/json} }
    #
    #   puts "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeEE#{file_params.inspect}"
    #   file_params.each do |name,file|
    #     file.rewind
    #     params[name] = ActiveSupport::JSON.decode(file.read)
    #
    #     puts "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeEE#{params[name]}"
    #   end
    # end
   
    def configure_devise_params
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:login,:mobile, :email, :password, :password_confirmation,:unhashed_password,:term_condition,:imei)
      end
    end
  
    def  after_sign_in_path_for(resource)
      if current_user.role == 'admin'
        admin_index_path
      else
        users_path
      end
    end
  
    #  before_filter :configure_devise_params, if: :devise_controller?

    #  def configure_devise_params
    #    devise_parameter_sanitizer.for(:sign_up) do |u|
    #      u.permit(:user_name,:price,:role, :address_line1, :address_line2, :city, :state, :pincode, :phone_number,  :gender, :email, :password, :password_confirmation)
    #    end
    #  end
  
    #  def  after_sign_in_path_for(resource)
    #    if current_user.role == 'admin'
    #      admins_path
    #    else
    #      user_profiles_path
    #    end
    #  end
    def convert_html_safe(str)
      return str.html_safe
    end
  
  
  
  end
