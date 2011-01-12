class DesignDetailDataPointsController < ApplicationController
  # GET /design_detail_data_points
  # GET /design_detail_data_points.xml
  def index
    @design_detail_data_points = DesignDetailDataPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @design_detail_data_points }
    end
  end

  # GET /design_detail_data_points/1
  # GET /design_detail_data_points/1.xml
  def show
    @design_detail_data_point = DesignDetailDataPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @design_detail_data_point }
    end
  end

  # GET /design_detail_data_points/new
  # GET /design_detail_data_points/new.xml
  def new
    @design_detail_data_point = DesignDetailDataPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @design_detail_data_point }
    end
  end

  # GET /design_detail_data_points/1/edit
  def edit
    @design_detail_data_point = DesignDetailDataPoint.find(params[:id])
  end

  # POST /design_detail_data_points
  # POST /design_detail_data_points.xml
  def create
	respond_to do |format|
		DesignDetailDataPoint.save_data_point_info(session[:study_id], params)
		#DesignDetailDataPoint.save_data_point_totals(session[:study_id], params)
	      format.js {
			  	render :update do |page|
						page.replace_html 'population_characteristic_validation_message', "Saved"
			  	end
				}		
	end
  end

  # PUT /design_detail_data_points/1
  # PUT /design_detail_data_points/1.xml
  def update
	DesignDetailDataPoint.save_data_point_info(params[:study_id], params)
	#DesignDetailDataPoint.save_data_point_totals(params[:study_id], params)
    respond_to do |format|
    end
  end

  # DELETE /design_detail_data_points/1
  # DELETE /design_detail_data_points/1.xml
  def destroy
    @design_detail_data_point = DesignDetailDataPoint.find(params[:id])
    @design_detail_data_point.destroy

    respond_to do |format|
      format.html { redirect_to(design_detail_data_points_url) }
      format.xml  { head :ok }
    end
  end
end
