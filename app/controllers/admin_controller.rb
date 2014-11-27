class AdminController < ApplicationController
  before_filter :authenticate_user!, except: [:icon_download]
  
  def index
    @users = User.all
  end
 
  def send_mail    
    @user = User.find(params[:id])    
    UserMailer.notification_for_term_condition(@user).deliver  if @user   
    redirect_to :back
  end
  
  def set_privileged    
    begin
      mdevise = Mobdevise.where(:id=>params[:id]).first
      p "=======================#{mdevise.inspect}"
      mdevise.privileged == 1? mdevise.update_attributes!(:privileged=>0) : mdevise.update_attributes!(:privileged=>1)
      redirect_to :back
    rescue Exception => e     
      flash[:error] = e.message
      redirect_to :back
    end
  end
  # Download link bit.ly/EGicon
  def icon_download
    begin
      user = User.where(:id=>params[:id])
      if user.present?
        #        user.update_attributes!(:term_condition => true)
        send_file "#{Rails.root}/public/software/Eliteguard-debug.apk"
        #        redirect_to root_path
      end
    rescue Exception => e
      puts "Error Message: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end
  
  def contact_us
    if params[:type] == "open"
      @contactus = ContactUs.where(:active=>true).paginate(:page => params[:page], :per_page => 25)
    else
      @contactus = ContactUs.where(:active=>false).paginate(:page => params[:page], :per_page => 25)
    end    
  end
  
  def active
    begin
      contactus = ContactUs.where(:id=>params[:id])
      contactus.active == true ?contactus.update_attributes!(:active=>false) : contactus.update_attributes!(:active=>true)
      redirect_to :back
    rescue Exception => e     
      flash[:error] = e.message
      redirect_to :back
    end
  end
  
  def upload
    begin
      #      uploader = CardFile.new(params[:card_file][:file])
      UploadLocationFile.create!(gallery_params)
      redirect_to :back
    rescue Exception => e
      logger.info "ssssssssssssssssssssssssssssssssss#{e.message}"
      p "==========================================================#{e.message}"
      flash[:error] = e.message
      redirect_to :back
    end
  end
  
  private 
  def gallery_params
    params.require(:upload_location_file).permit(:file_name, :mobdevise_id, :file_size, :content_type, :is_present)
  end
  
end
