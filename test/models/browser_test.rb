# == Schema Information
#
# Table name: browsers
#
#  id           :integer          not null, primary key
#  mobdevise_id :integer
#  title        :string(255)
#  url          :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'test_helper'

class BrowserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
