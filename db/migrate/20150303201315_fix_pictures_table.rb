class FixPicturesTable < ActiveRecord::Migration
  def change
  	remove_column :page_blocks, :picture_id
  	add_column :pictures, :block_person_id, :integer

  end
end
