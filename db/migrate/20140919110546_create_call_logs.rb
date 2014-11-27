class CreateCallLogs < ActiveRecord::Migration
  def change
    create_table :call_logs do |t|
      t.references :mobdevise
      t.string    :mobile_number
      t.string    :call_type
      t.date      :date_time
      t.string    :call_duration      
      
      t.timestamps
    end
  end
end
