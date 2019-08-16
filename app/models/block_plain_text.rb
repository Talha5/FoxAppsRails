class BlockPlainText < PageBlock
	attr_accessible :content_value, :type, :cleaned_text

	belongs_to :page_block

	def cleanup
	  	cleanupText = self.content_value
	  	puts 'cleanup before format = ' + cleanupText.inspect
	  	cleanupText = format_url(cleanupText)
	  	puts 'cleanup after foramt = ' + cleanupText.inspect
	  	self['cleaned_text'] = cleanupText
	end

	def format_url(text)
  		#replace the url's a tag with '<a href="#" onclick="FRDataBreach.application.externalLink(\'{url}'\);">'
  		doc = Nokogiri::HTML(text)
  		puts 'change atags'
  		new_html = doc.xpath('//a').each { |aTag|
  			if aTag['href'] =~ /http/
	  			aTag.set_attribute('onclick', "FRDataBreach.application.externalLink(\'#{aTag['href']}\');");
	  			aTag.set_attribute('href', '#');
	  			aTag.set_attribute('target', '');
	  		end
	  		puts "aTag = #{aTag}"
  		}
  		puts 'new_html = ' + new_html.inspect
  		return doc.to_s
  	end

  	def picture
  		return nil
  	end
end