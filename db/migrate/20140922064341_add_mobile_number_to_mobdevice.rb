class AddMobileNumberToMobdevice < ActiveRecord::Migration
  def change
    add_column :mobdevises, :user_id, :integer
  end
end
