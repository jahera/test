class CreateBrowsers < ActiveRecord::Migration
  def change
    create_table :browsers do |t|
      t.references :mobdevise, :index => true
      t.string    :title
      t.string    :url
      t.timestamps
    end
  end
end
