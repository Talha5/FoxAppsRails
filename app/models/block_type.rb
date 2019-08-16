class BlockType < ActiveRecord::Base
	attr_accessible :name
	has_many :page_blocks
end