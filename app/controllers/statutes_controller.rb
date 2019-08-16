class StatutesController < ProtectedApplicationController

  # GET /statutes
  # GET /statutes.json
  def index
    @statutes = Statute.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statutes }
    end
  end

  # GET /statutes/1
  # GET /statutes/1.json
  def show
    @statute = Statute.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @statute }
    end
  end

  # GET /statutes/new
  # GET /statutes/new.json
  def new
    @statute = Statute.new
    @statute_type = StatuteType.find(params[:statute_type_id])
    @statute.statute_type_id = @statute_type.id
    @jurisdictions = Jurisdiction.order('name')
    @form_action = "create"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @statute }
    end
  end

  # GET /statutes/1/edit
  def edit
    @statute = Statute.find(params[:id])
    @statute_type = StatuteType.find(params[:statute_type_id])
    @jurisdictions = Jurisdiction.order('name')
    @form_action = "update"
  end

  # POST /statutes
  # POST /statutes.json
  def create
    @statute = Statute.new(params[:statute])
    @statuteUpdate = StatuteType.find(params[:statute_type_id])
    @statute.statute_type_id = @statuteUpdate.id

    respond_to do |format|
      if @statute.save
        format.html { redirect_to statute_type_url(@statute.statute_type_id), notice: 'Statute was successfully created.' }
        format.json { render json: @statute, status: :created, location: @statute }
      else
        format.html { render action: "new" }
        format.json { render json: @statute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statutes/1
  # PUT /statutes/1.json
  def update
    @statute = Statute.find(params[:id])

    respond_to do |format|
      if @statute.update_attributes(params[:statute])
        format.html { redirect_to statute_type_url(@statute.statute_type_id), notice: 'Statute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @statute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statutes/1
  # DELETE /statutes/1.json
  def destroy
    @statute = Statute.find(params[:id])
    @statute_type_id = @statute.statute_type_id
    @statute.destroy

    respond_to do |format|
      format.html { redirect_to statute_type_url(@statute_type_id) }
      format.json { head :no_content }
    end
  end
end
