class CreateUploadLocationFiles < ActiveRecord::Migration
  def change
    create_table :upload_location_files do |t|
        t.references :mobdevise, :index => true
        t.string     :file_name
        t.integer    :file_size
        t.string     :content_type
        #t.string     :file_native_url
        t.boolean    :is_present,       :default  => true
        t.timestamps
    end
  end
end
