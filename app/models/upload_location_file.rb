class UploadLocationFile < ActiveRecord::Base
  mount_uploader :file_name, FileUploader
  belongs_to :mobdevise
  #  geocoded_by :full_address
  
  def self.get_location_date(mobdevise_id)
    #    location = self.where(:mobdevise_id => mobdevise_id)
    ss = self.select([:id, :file_name]).where('mobdevise_id = ?', mobdevise_id)
    #    cc = ss.collect{|l| [Time.at((l.file_name.to_s.split('/')[-1].split('.')[0]).to_s[0..-3].to_i/1000).in_time_zone('Kolkata'),l.id]}
    cc = ss.collect{|l| [l.file_name.to_s.split('/')[-1].split('.')[0],l.id]}
  end
  

#  def self.formate_location (lat,long)
##    query = location.latitude.to_s + "," + location.longitude.to_s 
#    result = Geocoder.search("#{lat},#{long}").first
#    # check for null, get the city, and put it in the array
#    if (result)
#      return data = result.city + '_' + result.country_code + '_'+ result.postal_code + '_' +result.formatted_address
##      cities.push(city)
#    end
##    return Geocoder.search("#{lat},#{long}")
#  end
  
end
