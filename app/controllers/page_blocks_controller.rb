class PageBlocksController < ProtectedApplicationController

	def new
		@block = PageBlock.new
		@block.content_page_id = params[:content_page_id]
		pageBlocks = PageBlock.where({:content_page_id => params[:content_page_id]}).order(:order_count)
		puts "pageBlocks = " + pageBlocks.inspect
		if pageBlocks.any?
			lastNumber = pageBlocks.last[:order_count].to_i
			@block.order_count = lastNumber + 1
		else
			@block.order_count = 1
		end
		puts 'block.order_count = ' + @block.order_count.inspect

		@blockTypes = BlockType.all.map {|block_type| [block_type.name, block_type.id]}
		puts 'blockTypes = ' + @blockTypes.inspect
		@form_action = 'create'
		puts 'form_action = ' + @form_action.inspect

		@editingBlock = true
		respond_to do |format|
	      #format.html # new.html.erb
	      format.js { render :new_block }
	      format.json { render json: @block }
	    end
	end

	def edit
		puts 'edit block params = ' + params.inspect
		puts 'params[:id] = ' + params[:id].inspect
		@myBlock = PageBlock.find(params[:id])
		@page = ContentPage.find(@myBlock.content_page_id)
		puts 'block = ' + @myBlock.inspect
		puts 'page = ' + @page.inspect

		@editingBlock = true

		respond_to do |format|
			if @myBlock.block_type_id == 1
				@blockPerson = BlockPerson.find(@myBlock.id)
				puts 'blockPerson = ' + @blockPerson.inspect
				@path = update_block_person_path(@blockPerson.content_page_id, @blockPerson)
				format.js { render :edit_block_person }
	      		format.json { render json: @blockPerson }
			else
				@blockText = BlockPlainText.find(@myBlock.id)
				puts 'blockText = ' + @blockText.inspect
				@path = update_block_plain_text_path(@blockText)
				format.js { render :edit_block_text }
	      		format.json { render json: @blockText }
			end
	    end
	end

	def destroy
		puts 'destroy_page_block params = ' + params.inspect
		@block = PageBlock.find(params[:id])
		puts 'block = ' + @block.inspect
		page_id = @block.content_page_id
		puts 'page_id = ' + page_id.inspect
		order_number = @block.order_count
		puts 'order number = ' + order_number.inspect
		all_blocks = PageBlock.where({:content_page_id => page_id}).order('order_count')
		puts 'all_blocks before each = ' + all_blocks.inspect
		#change order of blocks so theydon't include block about to be deleted
		all_blocks.each do |b|
			if b.order_count > order_number
				b.order_count = b.order_count - 1
				b.save
			end
		end
		puts 'all_blocks after each = ' + all_blocks.inspect
		@block.destroy

		respond_to do |format|
	      format.html { redirect_to show_content_pages_path(page_id) }
	      format.json { head :no_content }
	    end
	end

	def create
		puts 'params = ' + params.inspect
		blockInfo = params[:page_block]
		@block = PageBlock.new(blockInfo)
		@page = ContentPage.where(@block.content_page_id).first

		respond_to do |format|
			puts 'format = ' + format.inspect
	      	if @block.block_type_id == 1
	      		@blockPerson = BlockPerson.new

	      		#set hidden values
	      		@blockPerson.order_count = @block.order_count
	      		@blockPerson.content_page_id = @block.content_page_id
	      		@blockPerson.block_type_id = @block.block_type_id
	      		puts 'blockPerson = ' + @blockPerson.inspect
	      		#set path
	      		@path = create_block_person_path
	      		#render
	        	format.js { render :new_person }
	      		format.json { render json: @blockPerson }
	        elsif @block.block_type_id == 2
	        	@blockText = BlockPlainText.new

	        	#set hidden values
	      		@blockText.order_count = @block.order_count
	      		@blockText.content_page_id = @block.content_page_id
	      		@blockText.block_type_id = @block.block_type_id
	      		puts 'blockPerson = ' + @blockText.inspect
	      		#set path
	      		@path = create_block_text_path
	      		#render
	        	format.js { render :new_text }
	      		format.json { render json: @blockText }
	        end
	    end
	end

	def create_block_person
		puts 'create_block_person params = ' + params.inspect
		@blockPerson = BlockPerson.new(params[:block_person])
		# url = @blockPerson.get_picture_url
		# uriRequest = URI(request.url) + url
		# puts 'uriReq = '+ uriRequest.inspect
		# @blockPerson.picture_url = uriRequest.to_s
		puts '@blockPerson = ' + @blockPerson.inspect
		pageId = @blockPerson[:content_page_id]
		@page = ContentPage.find(pageId)
		puts 'page = ' + @page.inspect

		respond_to do |format|
	      if @blockPerson.save
	      	url = @blockPerson.get_picture_url
			uriRequest = URI(request.url) + url
			puts 'uriReq = '+ uriRequest.inspect
			@blockPerson.picture_url = uriRequest.to_s
			if @blockPerson.save
		      	@editingBlock = false
		        format.html { redirect_to show_content_pages_path(@page.id), notice: 'Person was successfully created.' }
		        format.json { render json: @blockPerson, status: :created, location: @blockPerson }
		    else
		    	format.html { render action: "new_block_person", alert: 'Unable to create picture url successfully.'}
	        	format.json { render json: @blockPerson.errors, status: :unprocessable_entity }
	        end
	      else
	        format.html { render action: "new_block_person", alert: 'Unable to create Person.' }
	        format.json { render json: @blockPerson.errors, status: :unprocessable_entity }
	      end
	    end

	end

	def create_block_text
		puts 'create_block_text params = ' + params.inspect
		@blockText = BlockPlainText.new(params[:block_plain_text])
		puts '@blockText = ' + @blockText.inspect
		@blockText.cleanup
		pageId = @blockText[:content_page_id].inspect
		@page = ContentPage.find(pageId)
		puts 'page = ' + @page.inspect

		respond_to do |format|
	      if @blockText.save
	      	@editingBlock = false
	        format.html { redirect_to show_content_pages_path(@page.id), notice: 'Text Block was successfully created.' }
	        format.json { render json: @blockPerson, status: :created, location: @blockText }
	      else
	        format.html { render action: "new_block_plain_text" }
	        format.json { render json: @blockText.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def update_block_person
		puts 'update block person params = ' + params.inspect
		@pic = nil
		@blockPerson = BlockPerson.find(params[:id])
		@page_id = @blockPerson.content_page_id

		respond_to do |format|
			if @blockPerson.update_attributes(params[:block_person])
				url = @blockPerson.get_picture_url
				uriRequest = URI(request.url) + url
				puts 'uriReq = '+ uriRequest.inspect
				@blockPerson.picture_url = uriRequest.to_s
				#@blockPerson.picture_url = URI.join(request.url, url)
				puts 'blockPerson after get_picture_url = ' + @blockPerson.inspect
				if @blockPerson.save
					@editingBlock = false
					format.html { redirect_to show_content_pages_path(@page_id), notice: 'Block was successfully updated.' }
		        	format.json { head :no_content }
		        else
		        	format.html { render edit_page_blocks_path(@blockPerson.id), alert: 'Unable to save picture url successfully.'}
	        		format.json { render json: @blockPerson.errors, status: :unprocessable_entity }
	        	end
			else
				format.html { render edit_page_blocks_path(@blockPerson.id), alert: 'Unable to update Block successfully.'}
	        	format.json { render json: @blockPerson.errors, status: :unprocessable_entity }
			end
		end
	end

	def update_block_plain_text
		puts 'upddate block text params = ' + params.inspect
		@blockText = BlockPlainText.find(params[:id])
		@page_id = @blockText.content_page_id

		respond_to do |format|
			if @blockText.update_attributes(params[:block_plain_text])
				@blockText.cleanup
				if @blockText.save
					@editingBlock = false
					format.html { redirect_to show_content_pages_path(@page_id), notice: 'Block was successfully updated.' }
					format.json { head :no_content }
				else
					format.html { render edit_page_blocks_path(@blockText.id), alert: 'Unable to update Block-cleanup successfully.' }
					format.json { render json: @blockText.errors, status: :unprocessable_entity }
				end
			else
				format.html { render edit_page_blocks_path(@blockText.id), alert: 'Unable to update Block successfully.' }
				format.json { render json: @blockText.errors, status: :unprocessable_entity }
			end
		end
	end

	def create_pic
		puts 'create_photo params = ' + params.inspect
		@blockPerson_id = params[:id]
		puts 'blockPerson_id = ' + @blockPerson_id.inspect
		#@pic.destroy
		@blockPerson = BlockPerson.find(@blockPerson_id)
		@editingBlock = true

		respond_to do |format|
			#@path = update_pic_path(@blockPerson.content_page_id,@blockPerson, :format => :js)
			@path = update_pic_path(@blockPerson.content_page_id,@blockPerson)
			puts 'creat_pic-> path = ' + @path.inspect
			format.js { render :create_pic }
      		format.json { render json: @blockPerson }
      	end
	end

	def update_pic
		puts 'update_pic params = ' + params.inspect
		pictureParams = (params[:block_person])[:picture_attributes]
		puts 'pictureParams = ' + pictureParams.inspect
		block_id = params[:id]
		puts 'block_id = ' + block_id.inspect
		Picture.where('block_person_id = ? AND id <> ?', block_id, pictureParams[:id]).delete_all
		@blockPerson = BlockPerson.find(block_id)
		puts 'blockPerson = ' + @blockPerson.inspect
		@page = ContentPage.find(params[:content_page_id])
		puts 'page = ' + @page.inspect

		respond_to do |format|
			if @blockPerson.update_attributes(params[:block_person])
        url = @blockPerson.get_picture_url
        uriRequest = URI(request.url) + url
        puts 'uriReq = '+ uriRequest.inspect
        @blockPerson.picture_url = uriRequest.to_s
        if @blockPerson.save
  				@editingBlock = false
  				# @path = update_block_person_path(@blockPerson)
  				# format.js { render :edit_block_person }
  	   			# format.json { render json: @blockPerson }
  				format.html { redirect_to show_content_pages_path(@page.id), notice: 'Picture and Person was successfully updated.' }
  				format.json { render json: @page }
  			else
  				format.html { render create_pic_path(@page.id, @blockPerson.id), alert: 'Unable to update picture successfully.' }
  				format.json { render json: @blockPerson }
  			end
      else
        format.html { render create_pic_path(@page.id, @blockPerson.id), alert: 'Unable to update picture successfully.' }
        format.json { render json: @blockPerson }
      end
		end
	end

	def move_up
		block_id = params[:content_page_id]
		currentBlock = PageBlock.find(block_id)
		puts 'currentBlock = ' + currentBlock.inspect
		before_count = currentBlock.order_count - 1
		beforeBlock = PageBlock.where({:content_page_id => currentBlock.content_page_id, :order_count => before_count}).first
		puts 'beforeBlock = ' + beforeBlock.inspect
		beforeBlock.order_count = currentBlock.order_count
		currentBlock.order_count = before_count

		currentBlock.save
		beforeBlock.save

		redirect_to show_content_pages_path(currentBlock.content_page_id)
	end

	def move_down
		block_id = params[:content_page_id]
		currentBlock = PageBlock.find(block_id)
		after_count = currentBlock.order_count + 1
		afterBlock = PageBlock.where({:content_page_id => currentBlock.content_page_id, :order_count => after_count}).first
		afterBlock.order_count = currentBlock.order_count
		currentBlock.order_count = after_count

		currentBlock.save
		afterBlock.save

		redirect_to show_content_pages_path(currentBlock.content_page_id)
	end

end
