class RenameCurrentLocTimeToDeviceLocations < ActiveRecord::Migration
  def change
    change_column :device_locations, :current_loc_time, :string
  end
end
