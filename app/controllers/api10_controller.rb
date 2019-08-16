class Api10Controller < ApplicationController

  def jurisdiction_list
    if params.has_key?(:lng) && params.has_key?(:lat)
      @jurisdictions = Jurisdiction.geo_scope(:origin => [ params[:lat],  params[:lng] ]).order('distance ASC')
      res = Geokit::Geocoders::GoogleGeocoder3.reverse_geocode([params[:lat], params[:lng]])
      @jurisdictions.each {|jurisdiction| if (jurisdiction.short_name == res.state) then jurisdiction.distance = 0 end }
    else
      @jurisdictions = Jurisdiction.all
    end
    
  	respond_to do |format|
      format.json { render :json => { :jurisdictions => @jurisdictions} }
      format.xml { render :xml => @jurisdictions }
    end
  end

  def jurisdiction_statute
  	@statute = Statute.joins(:statute_type).where('statute_types.name = ? and jurisdiction_id = ?', 'Data Breach', params[:id]).first
  	respond_to do |format|
      format.json { render :json => { :statute => @statute} }
      format.xml { render :xml => @statute }
    end
  end

  def jurisdiction_statutes
    @statutes = Statute.joins(:statute_type).where('statute_types.name = ? and jurisdiction_id = ?', 'Data Breach', params[:id])
    @jurisdiction_text = TextEntry.joins(:statute_type).where('statute_types.name = ? and jurisdiction_id = ?', 'Data Breach', params[:id]).first
    respond_to do |format|
      format.json { render :json => { :statutes => @statutes, :jurisdiction_text => @jurisdiction_text } }
      format.xml { render :xml => @statutes }
    end
  end

  #GET 'API10/content_pages/:name/all_page_blocks'
  #no view, just for the mobile app
  def get_all_page_blocks
    @page = ContentPage.where('name = ?', params[:name]).first
    @blocks = PageBlock.where({:content_page_id => @page.id}).order('order_count')

    respond_to do |format|
      format.json { render :json => @blocks }
      format.xml { render :xml => @blocks }
    end
  end
end
