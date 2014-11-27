class CardFile < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :mobdevise
  
#  attr_accessible :file,:mobdevise_id,:file_name,:file_size,:content_type,:is_present

end
