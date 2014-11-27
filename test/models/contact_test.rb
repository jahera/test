# == Schema Information
#
# Table name: contacts
#
#  id            :integer          not null, primary key
#  mobdevise_id  :integer
#  con_id        :integer
#  name          :string(255)
#  mobile_number :string(255)
#  email         :string(255)
#  display_name  :string(255)
#  dob           :date
#  note          :text
#  ip            :string(255)
#  photo         :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
