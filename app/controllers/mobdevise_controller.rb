class MobdeviseController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def create
    params_device = {
      :name     => params[:name],
      :model    => params[:model],
      :version  => params[:version],

      :platform => params[:platform],
      :devise_id     => params[:devise_id],
      :ip       => request.remote_ip
    }
    mobile_number = params[:mPhoneNumber]
    logger.info "requested device Mobile number #{mobile_number}}"
    logger.info "requested device IMEI number #{params[:imei]}"

    user_info = User.where(:mobile=> params[:mPhoneNumber]).first
    logger.info "Requested user information #{user_info.inspect}"

    old_device_id = Mobdevise.where(:devise_id => params[:device_id]).first

    if user_info != nil || old_device_id != nil
       device = Mobdevise.where(:devise_id => params[:devise_id]).first_or_initialize

      begin
        device.user_id = user_info.id
        device.update_attributes!(params_device)
        render :json => device
      rescue Exception => e
        puts "Error Message:" +  e.message.split('for')[0]
        render :json => e.message.split('for')[0], :status => :unprocessable_entity
      end
    end
  end
end
