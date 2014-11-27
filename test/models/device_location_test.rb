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

require 'test_helper'

class DeviceLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
