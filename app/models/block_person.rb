class BlockPerson < PageBlock
  attr_accessible :name, :title, :email, :phone, :picture_attributes, :type, :url, :picture_url

  belongs_to :page_block
  has_one :picture, dependent: :destroy
  accepts_nested_attributes_for :picture, allow_destroy: true

  def hasPicture
    if self.id.nil? 
      return false
    end
    puts 'self.id = ' + self.id.inspect
    pictures = Picture.where({:block_person_id => self.id}).all
    puts 'pictures = ' + pictures.inspect
    if pictures.any?
      puts 'returning true'
      return true
    else
      puts 'returning false'
      return false
    end
  end

  def get_picture
    if self.hasPicture
      return Picture.where({:block_person_id => self.id}).first
    else
      return false
    end
  end

  def get_picture_url
    if self.hasPicture
      return self.get_picture.public_url
    end
  end

end