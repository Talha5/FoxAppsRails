class ChangeColumnTypeCleanedText < ActiveRecord::Migration
  def change
  	change_column :page_blocks, :cleaned_text, :text
  end
end
