class AddShortNameToJurisdiction < ActiveRecord::Migration
  def change
    add_column :jurisdictions, :short_name, :string
  end
end
