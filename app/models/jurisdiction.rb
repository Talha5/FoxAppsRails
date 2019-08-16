class Jurisdiction < ActiveRecord::Base
  acts_as_mappable
  attr_accessible :name, :lat, :lng, :zip, :short_name
  has_many :statutes
  before_validation :geocode_address

  def geocode_address
  	!zip ? return : nil
    #geo = Geokit::Geocoders::MultiGeocoder.geocode(zip)
    geo = Geokit::Geocoders::GoogleGeocoder3.geocode(zip)
    puts zip
    puts geo
    self.lat, self.lng = nil,nil if !geo.success
    self.lat, self.lng = geo.lat,geo.lng if geo.success
  end
end
