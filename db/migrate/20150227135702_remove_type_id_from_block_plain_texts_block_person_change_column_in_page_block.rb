class RemoveTypeIdFromBlockPlainTextsBlockPersonChangeColumnInPageBlock < ActiveRecord::Migration
  def change
  	remove_column :block_plain_texts, :type_id
  	remove_column :block_people, :type_id
  	remove_column :page_blocks, :page_id

  	rename_column :page_blocks, :content_id, :content_page_id
  	rename_column :page_blocks, :type_id, :block_type_id
  end
end
