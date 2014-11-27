class AddColumnToContactUs < ActiveRecord::Migration
  def change
    add_column :contact_us, :active, :boolean , default: true
  end
end
