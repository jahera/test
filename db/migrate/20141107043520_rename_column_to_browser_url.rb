class RenameColumnToBrowserUrl < ActiveRecord::Migration
  def up
    change_column :browsers, :url, :text
  end

  def down
    change_column :browsers, :url, :string
  end
end
