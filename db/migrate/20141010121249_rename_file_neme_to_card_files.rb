class RenameFileNemeToCardFiles < ActiveRecord::Migration
  def change
    rename_column :card_files, "file_name", "file"
  end
end
