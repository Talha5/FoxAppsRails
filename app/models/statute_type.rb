class StatuteType < ActiveRecord::Base
  attr_accessible :name, :name_slug
  has_many :statutes
  has_many :text_entries
end
