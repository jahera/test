class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.text :name
      t.text :email
      t.text :subject

      t.timestamps
    end
  end
end
