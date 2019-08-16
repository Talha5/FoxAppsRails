class ContentPagesController < ProtectedApplicationController

  # GET 'content_pages/', content_pages_path
  # views/content_pages/index.html.erb
  # view a list of content pages
  def index
    @pages = ContentPage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  # GET 'content_pages/show/:id', show_content_pages_path(@page.id)
  #views/content_pages/show.html.erb
  #shows a singular content_page (static)
  def show
    @page = ContentPage.find(params[:id])
    @blocks = PageBlock.where(:content_page_id => @page.id).order('order_count')
    if !@blocks.any?
      @blocks = nil
    end
    @editingPage = false
    @editingBlock = false

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @page }
    end
  end

  # GET 'content_pages/new', content_pages_new_path
  # views/content_pages/new.html.erb => _form.html.erb
  # uses @form_action = 'create' and create method to create a new content_page within the _form.html.erb
  def new
    @page = ContentPage.new
    @blocks = nil
    #@newBlock = PageBlock.new
    @form_action = "create_page"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET 'content_pages/edit/:id', edit_content_pages_path(@page.id)
  # views/content_pages/edit.html.erb => _form.html.erb
  # uses the @form_action = 'update' and the update method to change the selected content_page withink the _form.html.erb
  def edit
    @page = ContentPage.find(params[:id])
    @editingPage = true
    @form_action = "update"
    respond_to do |format|
      format.js { render :edit_page }
      format.json { render json: @page}
    end
  end

  # POST 'content_pages/create'
  # creates and saves a new content_page when submit button is clicked
  # if successful, go to show.html.erb
  def create_page
    puts 'params = ' + params.inspect
    puts params[:content_page].inspect
    puts params[:content_page['name']].inspect
    @page = ContentPage.new(params[:content_page])
    puts '@page = ' + @page.inspect

    respond_to do |format|
      if @page.save
        format.html { redirect_to show_content_pages_path(@page.id), notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created }
      else
        format.html { render :controller => 'content_pages', action: "new", alert: 'There were Errors. Could not Create a New Page.' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT 'content_pages/update/:id'
  # updates and saves the selected content_page when submit button is clicked
  # if successful, go to show.html.erb
  def update
    @page = ContentPage.find(params[:id])
    respond_to do |format|
      if @page.update_attributes(params[:content_page])
         @editingPage = false
        format.html { redirect_to show_content_pages_path(@page.id), notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_content_pages_path(@page.id), alert: 'Unable to update Page successfully.'}
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE 'content_pages/destroy/:id', destroy_content_pages(@page.id)
  # deletes the selected content_page and known associations
  # if selected go to index.html.erb
  def destroy
    @page = ContentPage.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to content_pages_path }
      format.json { head :no_content }
    end
  end
end