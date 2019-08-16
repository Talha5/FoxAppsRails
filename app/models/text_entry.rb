class TextEntry < ActiveRecord::Base
  attr_accessible :jurisdiction_id, :statute_type_id, :text_value
  belongs_to :statute_type
  belongs_to :jurisdiction

  def shorten_text_value
    (text_value.length > 70 ? text_value[0..67] + '...' : text_value)
  end
end
