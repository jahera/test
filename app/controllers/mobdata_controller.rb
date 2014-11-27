class MobdataController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :get_device, except: [:create_contact_detail]
  before_action :get_device_id
  
  def create_browser
    begin
      params_browsers = {
        :title   => params[:title],
        :url   => params[:url]
      }
      browser_history = @device.browsers.where(:title => params[:title]).first_or_initialize
      browser_history.update_attributes!(params_browsers)
      render :json => browser_history
    rescue Exception => e
      puts "Error in browser history data: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end

  def create_text_messages
    begin
      params_test_messages = {
        :address   => params[:address],
        :msg_type  => params[:msg_type],
        :date_time => params[:date_time],
        :body      => params[:body]
      }

      text_message = @device.text_msgs.where(:date_time => params[:date_time]).first_or_initialize

      text_message.update_attributes!(params_test_messages)
      render :json => text_message
    rescue Exception => e
      puts "Error in text message inbox and sent box: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end

  def create_call_log
    begin
      params_call_logs = {
        :mobile_number   => params[:mobile_number],
        :call_type  => params[:call_type],
        :date_time => params[:date_time],
        :call_duration      => params[:call_duration]
      }

      # second  = (params[:date_time].to_f / 1000)
      # # date_time = params[:date_time].to_date
      #
      # date_time = Time.at(second).to_datetime
      #
      cal_logs = @device.call_logs.where(:date_time => params[:date_time]).first_or_initialize

      cal_logs.update_attributes!(params_call_logs)
      render :json => cal_logs
    rescue Exception => e
      puts "Error in call logs: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end

  def create_contact

    begin
      params_contacts = {
        :name   => params[:name],
        :mobile_number  => params[:mobile_number],
        :con_id => params[:con_id],

      }

      contacts = @device.contacts.where(:mobile_number => params[:mobile_number]).first_or_initialize

      contacts.update_attributes!(params_contacts)
      render :json => contacts
    rescue Exception => e
      puts "Error in contact: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end



  def create_contact_detaisl
    params_contact = {
      :con_id        => params[:con_id],
      :display_name  => params[:display_name],
      :name          => params[:name],
      :nick_name     => params[:nick_name],
      :dob           => params[:dob],
      :note          => params[:note],
      :ip            => request.remote_ip
    }
    contact = @device.contacts.where(:con_id => params[:con_id]).first_or_initialize
    begin
      contact.update_attributes!(params_contact)
      params[:phone_numbers].split("*").each do |phone|
        unless phone.blank?
          phone_value = phone.split(",")
          contact_detail =  contact.contact_details.where(:desc => phone_value[0]).first_or_initialize
          contact_detail.update_attributes(:detail_type => phone_value[01])
        end
      end if params[:phone_numbers].present?

      params[:phone_emails].split("*").each do |email|
        unless email.blank?
          email_value = email.split(",")
          contact_detail =  contact.contact_details.where(:desc => email_value[0]).first_or_initialize
          contact_detail.update_attributes(:detail_type => email_value[01])
        end
      end if params[:phone_emails].present?
      render :json => contact
    rescue Exception => e
      puts "Error Message: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end


  def create_contact_detail
    params_detail = {
      :desc   => params[:desc],
      :detail_type   => params[:type]
    }
    contact = Contact.find(params[:contact_id])

    contact_detail = contact.contact_details.where(:desc => params[:desc]).first_or_initialize
    begin
      contact_detail.update_attributes!(params_detail)
      render :json => contact_detail
    rescue Exception => e
      puts "Error Message in Saving Contact Detail: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end

  def upload
    begin
      contact = Contact.where(:con_id => params[:contact_id]).first      
      contact.photo = params[:file] # Assign a file like this, or
      contact.save!
      render :json => contact
    rescue Exception => e
      puts "Error in Uploading Contact Photo: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end

  # create storage card of android phone
  def create_card
    card = @device.cards.where(:card_type => params[:card_type], :native_url => params[:native_url]).first_or_initialize
    parent_card = @device.cards.where(:native_url => params[:parent_native_url]).first
    begin
      params_card = {
        :path   => params[:path],
        :name   => params[:name],
        :desc   => params[:desc]
      }
      params_card = params_card.merge(:parent_id => parent_card.id) if parent_card.present?
      card.update_attributes!(params_card)
      render :json => card
    rescue Exception => e
      puts "Error in Uploading Contact Photo: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end


  def create_upload_file
    begin
      #      #      card_files = CardFile.new(params[:card_file][:file])
      logger.info " Device id for upload image on the server #{@device_id.inspect}"
      #
      #
      #      @file = CardFile.where(:mobdevise_id =>@device_id.id,:file => params[:card_file][:file].original_filename).first
      #      card_file = @file.present? ? '' : @device_id.CardFile.create!(gallery_params)
      #      #      card_file = @device_id.card_files.create!(gallery_params)
      #
      #      #      @file = CardFile.where(:mobdevise_id =>@device_id.id,:file => params[:card_file][:file].original_filename).first
      #      #      card_file = @file.present? ? '' : @device_id.CardFile.create!(gallery_params)
      #      #      card_file = @device_id.card_files.create!(gallery_params)
      #      card_file = @device_id.CardFile.create!(gallery_params)
      #
      #      logger.info "--------------------------------------params[:devise_id]   #{params[:card_file][:mobdevise_id]}"
      #      logger.info "---------------------------------------------- #{params[:card_file][:file].original_filename if params[:card_file][:file]}"
      #      logger.info "********************************************"

      @file_count = CardFile.where(:mobdevise_id =>@device_id.id)
      if (@file_count.count <= 5)
        logger.info "****************************************************"
        @file = CardFile.where(:mobdevise_id =>@device_id.id,:file => params[:card_file][:file].original_filename).first
        card_file = @file.present? ? '' : @device_id.card_files.create!(gallery_params)
      end
      #      logger.info "********************************************"
      #      logger.info "-------------------------------->>>- #{card_file.id}"
      #      logger.info "********************************************"
      #      puts"======================================================#{card_file.inspect}"
      render :json => card_file
    rescue Exception => e
      #      puts "Error in Uploading Card File: " +  e.message
      logger.info "error in uploading file #{e.message}"
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end

  end

  def create_upload_location_file
    begin
      logger.info "request for upload location file via post #{@device_id.inspect}"
    #  params[:upload_location_file][:file_name].original_filename = "#{(Date.current.to_s)}#{File.extname(params[:upload_location_file][:file_name].original_filename)}"
       params[:upload_location_file][:file_name].original_filename ="#{Time.now.strftime("%m-%e-%y %H:%M").to_s}#{File.extname(params[:upload_location_file][:file_name].original_filename)}"
      location_file = @device_id.upload_location_files.create!(location_file_params)

      logger.info "location file rename name #{params[:upload_location_file][:file_name].original_filename }"
      render :json => location_file
    rescue Exception => e
      #      puts "Error in Uploading Card File: " +  e.message
      logger.info "error in uploading loaction file #{e}"
      logger.info "error in uploading loaction file #{e.message}"
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end


  def create_battery

    # begin
    #   logger.info "pppppppppppppppppppppp #{params[:battery_level]}"
    #   params_batterystatus = {
    #     :battery_level   => params[:battery_level],
    #     :is_plugged   => params[:is_plugged]
    #   }
    #   battery_status = @device.batterystatuses.where(:device_id => params[:device_id]).first_or_create
    #   # battery_status.update_attributes!(params_batterystatus)
    #   # render :json => battery_status
    # rescue Exception => e
    #   puts "Error in Uploading Contact Photo: " +  e.message.split('for')[0]
    #   render :json => e.message.split('for')[0], :status => :unprocessable_entity
    # end
  end

  def create_networkstate
    begin
      params_networkstate = {
        :network_state   => params[:network_state],
      }
      network_state = @device.networkstates.where(:device_id => params[:device_id]).first_or_create
      network_state.update_attributes!(params_networkstate)
      render :json => battery_status
    rescue Exception => e
      puts "Error in Uploading Contact Photo: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end

  def create_loc
    begin
      params_loc = {
        :lat => params[:lat],
        :lon => params[:lon],
        :accuracy => params[:accuracy],
        :current_loc_time => params[:cur_loc_time]
      }
      device_loc = @device.device_locations.new(params_loc)
      device_loc.save!
      render :json => device_loc
    rescue Exception => e
      puts "Error in Uploading Current Location: " +  e.message.split('for')[0]
      render :json => e.message.split('for')[0], :status => :unprocessable_entity
    end
  end

  private
  # get current device using uuid
  def get_device
    p "------------------------->>>>>>>>>>>>>>>>>>>>>..        #{params[:devise_id]}"
    @device = Mobdevise.where(:devise_id => params[:devise_id]).first
    #    @device = Mobdevise.find_by_devise_id(params[:device_id])
  end


  def gallery_params
    params.require(:card_file).permit(:file,:mobdevise_id,:file_size,:content_type,:is_present)
  end

  def location_file_params
    params.require(:upload_location_file).permit(:file_name, :mobdevise_id, :file_size, :content_type, :is_present)
  end
  
  def get_device_id
    logger.info "--------------------------------------params[:devise_id]ff   #{params[:mobdevise_id]}"
    @device_id = Mobdevise.where(:devise_id => params[:mobdevise_id]).first
    #    @device = Mobdevise.find_by_devise_id(params[:device_id])
  end
end