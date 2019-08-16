class Statute < ActiveRecord::Base
  attr_accessible :name, :url, :statute_type_id, :jurisdiction_id
  belongs_to :statute_type
  belongs_to :jurisdiction
end
