# == Schema Information
#
# Table name: mobdevises
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  model      :string(255)
#  version    :string(255)
#  platform   :string(255)
#  devise_id  :string(255)
#  ip         :string(255)
#  imei        :string(255)
#  privileged :integer          default(1)
#  d_type     :string(255)
#  created_at :datetime
#  updated_at :datetime

#

class Mobdevise < ActiveRecord::Base
  belongs_to  :user
  has_many    :contacts
  has_many    :text_msgs
  has_many    :device_locations
  has_many    :call_logs
  has_many    :browsers
  has_many    :card_files
  has_many    :upload_location_files
  
end
