class AddColumnToPageBlocks < ActiveRecord::Migration
  def change
  	add_column :page_blocks, :cleaned_text, :string
  end
end
