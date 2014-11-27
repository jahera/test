class SessionsController < Devise::SessionsController
  
  def destroy

#    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
#    #set_flash_message :notice, :signed_out if signed_out
#
#    respond_to do |format|
#      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
#      format.all do
#        head :no_content
#      end
#    end
  end
end
