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
#  privileged :integer          default(1)
#  d_type     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class MobdeviseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
