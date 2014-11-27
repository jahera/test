class CreateTextMsgs < ActiveRecord::Migration
  def change
    create_table :text_msgs do |t|
      t.references :mobdevise
      t.string    :address
      t.text      :body
      t.date      :date_time
      t.string    :msg_type
      
      t.timestamps
    end
  end
end
