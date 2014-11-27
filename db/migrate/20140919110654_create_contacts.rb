class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :mobdevise
      t.integer   :con_id
      t.string    :name
      t.string    :mobile_number
      t.string    :email
      t.string    :display_name
      t.date      :dob
      t.text      :note
      t.string    :ip
      t.string    :photo
      t.timestamps
    end
  end
end
