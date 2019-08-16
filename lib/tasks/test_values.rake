namespace :test_values do
	desc "Create BlockTypes"
	task load_block_types: :environment do
		BlockType.create!(name: 'Person')
		BlockType.create!(name: 'Text')
	end
 end