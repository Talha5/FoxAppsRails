class StatuteTypesController < ProtectedApplicationController
 
  def is_numeric?(obj) 
     obj.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
  # GET /statute_types
  # GET /statute_types.json
  def index
    @statute_types = StatuteType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statute_types }
    end
  end

  # GET /statute_types/1
  # GET /statute_types/1.json
  def show
    @id = params[:id]
    if is_numeric? @id
      @statute_type = StatuteType.find(params[:id])
    else
      @statute_type = StatuteType.find_by_name_slug(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statute_type }
    end
  end

  # GET /statute_types/new
  # GET /statute_types/new.json
  def new
    @statute_type = StatuteType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statute_type }
    end
  end

  # GET /statute_types/1/edit
  def edit
    @statute_type = StatuteType.find(params[:id])
  end

  # POST /statute_types
  # POST /statute_types.json
  def create
    @statute_type = StatuteType.new(params[:statute_type])

    respond_to do |format|
      if @statute_type.save
        format.html { redirect_to @statute_type, notice: 'Statute type was successfully created.' }
        format.json { render json: @statute_type, status: :created, location: @statute_type }
      else
        format.html { render action: "new" }
        format.json { render json: @statute_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statute_types/1
  # PUT /statute_types/1.json
  def update
    @statute_type = StatuteType.find(params[:id])

    respond_to do |format|
      if @statute_type.update_attributes(params[:statute_type])
        format.html { redirect_to @statute_type, notice: 'Statute type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statute_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statute_types/1
  # DELETE /statute_types/1.json
  def destroy
    @statute_type = StatuteType.find(params[:id])
    @statute_type.destroy

    respond_to do |format|
      format.html { redirect_to statute_types_url }
      format.json { head :no_content }
    end
  end
end
