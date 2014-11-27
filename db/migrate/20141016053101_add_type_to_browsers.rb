class AddTypeToBrowsers < ActiveRecord::Migration
  def change
    add_column :browsers, :type, :string
  end
end
