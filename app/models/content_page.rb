class ContentPage < ActiveRecord::Base
  attr_accessible :name

  has_many :page_blocks, dependent: :destroy
end