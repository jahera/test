class CreateDeviceLocations < ActiveRecord::Migration
  def change
    create_table :device_locations do |t|
      t.references :mobdevise, :index => true
      t.decimal    :lat,      precision: 10, scale: 7
      t.decimal    :lon,      precision: 10, scale: 7
      t.float      :accuracy
      t.datetime   :current_loc_time
      t.string     :address
      t.string     :city
      t.string     :state
      t.string     :country
      t.string     :zipcode 

      t.timestamps
    end
  end
end
