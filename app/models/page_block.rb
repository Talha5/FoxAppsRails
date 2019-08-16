class PageBlock < ActiveRecord::Base
  attr_accessible :content_page_id, :block_type_id, :order_count

  belongs_to :content_pages
  belongs_to :block_type

  # def hasPicture
  #   puts 'self.id = ' + self.id.inspect
  # 	pics = Picture.where({:block_person_id => self.id}).all
  #   puts 'pics = ' + pics.inspect
  # 	if pics.nil?
  # 		return false
  # 	else
  #     return true
  #   end
  # end

  # def picture
  # 	if self.hasPicture
  # 		return Picture.where({:block_person_id => self.id}).first
  # 	end
  # end

  def last
    blocks = PageBlock.where(:content_page_id => self.content_page_id).order('order_count')
    return blocks.last.order_count
  end

end