# == Schema Information
#
# Table name: text_msgs
#
#  id           :integer          not null, primary key
#  mobdevise_id :integer
#  address      :string(255)
#  body         :text
#  date_time    :date
#  msg_type     :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class TextMsgTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
