class BaselineCharacteristicDataPointsController < ApplicationController
  # GET /baseline_characteristic_data_points
  # GET /baseline_characteristic_data_points.xml
  def index
    @baseline_characteristic_data_points = BaselineCharacteristicDataPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @baseline_characteristic_data_points }
    end
  end

  # GET /baseline_characteristic_data_points/1
  # GET /baseline_characteristic_data_points/1.xml
  def show
    @baseline_characteristic_data_point = BaselineCharacteristicDataPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @baseline_characteristic_data_point }
    end
  end

  # GET /baseline_characteristic_data_points/new
  # GET /baseline_characteristic_data_points/new.xml
  def new
    @baseline_characteristic_data_point = BaselineCharacteristicDataPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @baseline_characteristic_data_point }
    end
  end

  # GET /baseline_characteristic_data_points/1/edit
  def edit
    @baseline_characteristic_data_point = BaselineCharacteristicDataPoint.find(params[:id])
  end

  # POST /baseline_characteristic_data_points
  # POST /baseline_characteristic_data_points.xml
  def create
	respond_to do |format|
		BaselineCharacteristicDataPoint.save_data_point_info(session[:study_id], params)
		#BaselineCharacteristicDataPoint.save_data_point_totals(session[:study_id], params)
	      format.js {
			  	render :update do |page|
						page.replace_html 'population_characteristic_validation_message', "Saved"
			  	end
				}		
	end
  end

  # PUT /baseline_characteristic_data_points/1
  # PUT /baseline_characteristic_data_points/1.xml
  def update
	BaselineCharacteristicDataPoint.save_data_point_info(params[:study_id], params)
	#BaselineCharacteristicDataPoint.save_data_point_totals(params[:study_id], params)
    respond_to do |format|
    end
  end

  # DELETE /baseline_characteristic_data_points/1
  # DELETE /baseline_characteristic_data_points/1.xml
  def destroy
    @baseline_characteristic_data_point = BaselineCharacteristicDataPoint.find(params[:id])
    @baseline_characteristic_data_point.destroy

    respond_to do |format|
      format.html { redirect_to(baseline_characteristic_data_points_url) }
      format.xml  { head :ok }
    end
  end
end
