class AddPictureUrlColumnToPageBlocks < ActiveRecord::Migration
  def change
  	add_column :page_blocks, :picture_url, :string
  end
end
