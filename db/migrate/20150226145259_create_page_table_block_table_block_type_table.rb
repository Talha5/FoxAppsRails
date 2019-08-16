class CreatePageTableBlockTableBlockTypeTable < ActiveRecord::Migration
  def change
  	create_table :content_pages do |t|
  		t.string :name

  		t.timestamps
  	end

  	create_table :page_blocks do |t|
  		t.integer :content_id, :type_id, :page_id, :order
  		t.timestamps
  	end

  	create_table :block_types do |t|
  		t.string :name
  		t.timestamps
  	end

  	create_table :block_plain_texts do |t|
  		t.text :content_value
  		t.integer :type_id, :page_block_id
  		t.timestamps
  	end

  	create_table :block_people do |t|
  		t.string :name, :title, :email, :phone
  		t.integer :picture_id, :type_id, :page_block_id
  		t.timestamps
  	end

  	create_table :pictures do |t|
  		t.string :file_name, :content_type
  		t.integer :file_size
  		t.timestamps
  	end

  end
end
