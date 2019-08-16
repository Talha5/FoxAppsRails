class TextEntriesController < ApplicationController
  # GET /text_entries
  # GET /text_entries.json
  def index
    @text_entries = TextEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @text_entries }
    end
  end

  # GET /text_entries/1
  # GET /text_entries/1.json
  def show
    @text_entry = TextEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text_entry }
    end
  end

  # GET /text_entries/new
  # GET /text_entries/new.json
  def new
    @jurisdictions = Jurisdiction.order('name')
    @text_entry = TextEntry.new
    @statute_type = StatuteType.find(params[:statute_type_id])
    @form_action = "create"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text_entry }
    end
  end

  # GET /text_entries/1/edit
  def edit
    @statute_type = StatuteType.find(params[:statute_type_id])
    @jurisdictions = Jurisdiction.order('name')
    @text_entry = TextEntry.find(params[:id])
    @form_action = "update"
  end

  # POST /text_entries
  # POST /text_entries.json
  def create
    @text_entry = TextEntry.new(params[:text_entry])

    respond_to do |format|
      if @text_entry.save
        format.html { redirect_to statute_type_url(@text_entry.statute_type_id), notice: 'Text entry was successfully created.' }
        format.json { render json: @text_entry, status: :created, location: @text_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @text_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /text_entries/1
  # PUT /text_entries/1.json
  def update
    @text_entry = TextEntry.find(params[:id])

    respond_to do |format|
      if @text_entry.update_attributes(params[:text_entry])
        format.html { redirect_to statute_type_url(@text_entry.statute_type_id), notice: 'Text entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_entries/1
  # DELETE /text_entries/1.json
  def destroy
    @text_entry = TextEntry.find(params[:id])
    @statute_type_id = @text_entry.statute_type_id
    @text_entry.destroy

    respond_to do |format|
      format.html { redirect_to statute_type_url(@statute_type_id) }
      format.json { head :no_content }
    end
  end
end
