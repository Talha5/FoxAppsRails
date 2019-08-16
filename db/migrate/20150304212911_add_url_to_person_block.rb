class AddUrlToPersonBlock < ActiveRecord::Migration
  def change
  	add_column :page_blocks, :url, :string
  end
end
