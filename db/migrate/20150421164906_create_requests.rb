class CreateRequests < ActiveRecord::Migration
  def change
  	create_table :requests do |t|
  		t.string :name
  		t.integer :length
  		t.integer :words
  		t.float :grade_level
  		t.boolean :longer_than_mk
  		t.boolean :more_words_than_mk
  		t.boolean :harder_than_mk
  	end
  end
end
