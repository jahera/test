class CreateMobdevises < ActiveRecord::Migration
  def change
    create_table :mobdevises do |t|
      t.string      :name
      t.string      :model
      t.string      :version
      t.string      :platform
      t.string      :devise_id
      t.string      :ip
      t.integer     :privileged , :default => true
      t.string      :d_type      
      t.timestamps
    end
  end
end
