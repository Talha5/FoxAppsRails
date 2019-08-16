class AddUrlToStatutes < ActiveRecord::Migration
  def change
    add_column :statutes, :url, :string
  end
end
