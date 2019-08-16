class FixPageBlocksTablesToBecomeOne < ActiveRecord::Migration
  def change
  	change_table :page_blocks do |t|
  		t.string :name, :title, :email, :phone
  		t.integer :picture_id
  		t.text :content_value
  	end

  	drop_table :block_people
  	drop_table :block_plain_texts
  end
end
