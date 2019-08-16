require 'paperclip'
class Picture < ActiveRecord::Base
  	attr_accessible :photo, :photo_file_name, :photo_content_type, :photo_file_size, :block_person_id

  	belongs_to :block_person
  	has_attached_file :photo,
	  	:styles => {
	  		:thumb => '80x100#',
	  		:small => '144x180'
	  	},
	  	:url => "/:class/:attachment/:id/:style_:basename.:extension",
	  	:path => ':rails_root/public/:class/:attachment/:id/:style_:basename.:extension',
	  	allow: :destroy

	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/png']

	def public_url
		puts 'public url = ' + self.photo.url(:thumb).inspect
		#return 'hostname' + self.photo.url(:thumb)
		
		return self.photo.url(:thumb)
	end
end