class AddColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unhashed_password, :string
    add_column :users, :term_condition, :integer , default: false
  end
end
