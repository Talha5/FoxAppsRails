module FormHelper
	def setup_block_person(blockPerson)
		blockPerson.picture ||= Picture.new
		blockPerson
	end
end