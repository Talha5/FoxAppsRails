class AddLatLngToJurisdiction < ActiveRecord::Migration
  def change
    add_column :jurisdictions, :lat, :float
    add_column :jurisdictions, :lng, :float
  end
end
