namespace :deactivation do
desc "Send mail to consumer for survey automatically a day after checkout date"
 
  task :auto_deactivate => :environment do
   
    deactivate = Mobdevise.all
    
    deactivate.each do |d|
      if (d.created_at.to_date == Date.today-7)
        d.update_attributes!(:privileged=>true)
      end
    end
    
  end
end