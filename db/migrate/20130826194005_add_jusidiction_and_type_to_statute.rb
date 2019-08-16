class AddJusidictionAndTypeToStatute < ActiveRecord::Migration
  def change
    add_column :statutes, :jurisdiction_id, :integer
    add_column :statutes, :statute_type, :integer
  end
end
