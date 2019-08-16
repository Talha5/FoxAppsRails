class FixPictureColumnNames < ActiveRecord::Migration
  def change
  	change_table :pictures do |t|
  		t.rename :file_name, :photo_file_name
  		t.rename :content_type, :photo_content_type
  		t.rename :file_size, :photo_file_size
  	end
  end
end
