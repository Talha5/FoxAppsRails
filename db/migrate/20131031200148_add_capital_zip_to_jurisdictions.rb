class AddCapitalZipToJurisdictions < ActiveRecord::Migration
  def change
    add_column :jurisdictions, :zip, :string
  end
end
