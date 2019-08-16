class RenameOrderColumnInPageBlocksTable < ActiveRecord::Migration
  def change
  	rename_column :page_blocks, :order, :order_count
  end
end
