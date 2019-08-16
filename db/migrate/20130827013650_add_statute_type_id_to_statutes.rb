class AddStatuteTypeIdToStatutes < ActiveRecord::Migration
  def change
    add_column :statutes, :statute_type_id, :integer
  end
end
