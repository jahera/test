class RenameDateToTextMessage < ActiveRecord::Migration
  def change
    change_column :text_msgs, :date_time, :datetime
  end


end
