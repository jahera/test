class ChangeColumnDateToStringCallLogs < ActiveRecord::Migration
  def change
    change_column :call_logs, :date_time, :string
  end
end
