class CreateRequests < ActiveRecord::Migration
  def change
  	create_table :requests do |t|
  		t.string :name
  		t.integer :length
  		t.boolean :longer_than_mk

      t.timestamps, null: false
  	end
  end
end
