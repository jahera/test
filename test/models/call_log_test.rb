# == Schema Information
#
# Table name: call_logs
#
#  id            :integer          not null, primary key
#  mobdevise_id  :integer
#  mobile_number :string(255)
#  call_type     :string(255)
#  date_time     :date
#  call_duration :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class CallLogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
