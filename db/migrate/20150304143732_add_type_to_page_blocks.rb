class AddTypeToPageBlocks < ActiveRecord::Migration
  def change
  	add_column :page_blocks, :type, :string
  end
end
