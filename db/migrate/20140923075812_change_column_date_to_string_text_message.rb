class ChangeColumnDateToStringTextMessage < ActiveRecord::Migration
  def change
    change_column :text_msgs, :date_time, :string
  end
end
