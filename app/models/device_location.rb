# == Schema Information
#
# Table name: device_locations
#
#  id               :integer          not null, primary key
#  mobdevise_id     :integer
#  lat              :decimal(10, 7)
#  lon              :decimal(10, 7)
#  accuracy         :float(24)
#  current_loc_time :datetime
#  address          :string(255)
#  city             :string(255)
#  state            :string(255)
#  country          :string(255)
#  zipcode          :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

class DeviceLocation < ActiveRecord::Base
  belongs_to :mobdevise
  #after_validation :get_date
  
  def self.get_date(mobdevise_id)
    location = self.where(:mobdevise_id => mobdevise_id)
    location.collect{|l| l.created_at.strftime('%Y-%m-%d')} 
  end

  reverse_geocoded_by :lat, :lon do |obj,results|
    if geo = results.first
      obj.address = geo.formatted_address
      obj.city    = geo.city
      obj.zipcode = geo.postal_code
      obj.country = geo.country_code
    end
  end
  after_validation :reverse_geocode
  
  

end
