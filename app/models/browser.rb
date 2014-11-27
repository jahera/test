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

class Browser < ActiveRecord::Base
  belongs_to :mobdevise
end
