class PopulationCharacteristicDataPointsController < ApplicationController
  # GET /population_characteristic_data_points
  # GET /population_characteristic_data_points.xml
  def index
    @population_characteristic_data_points = PopulationCharacteristicDataPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @population_characteristic_data_points }
    end
  end

  # GET /population_characteristic_data_points/1
  # GET /population_characteristic_data_points/1.xml
  def show
    @population_characteristic_data_point = PopulationCharacteristicDataPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @population_characteristic_data_point }
    end
  end

  # GET /population_characteristic_data_points/new
  # GET /population_characteristic_data_points/new.xml
  def new
    @population_characteristic_data_point = PopulationCharacteristicDataPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @population_characteristic_data_point }
    end
  end

  # GET /population_characteristic_data_points/1/edit
  def edit
    @population_characteristic_data_point = PopulationCharacteristicDataPoint.find(params[:id])
  end

  # POST /population_characteristic_data_points
  # POST /population_characteristic_data_points.xml
  def create
	respond_to do |format|
		PopulationCharacteristicDataPoint.save_data_point_info(session[:study_id], params)
		PopulationCharacteristicDataPoint.save_data_point_totals(session[:study_id], params)
	      format.js {
			  	render :update do |page|
						#page.replace_html 'population_characteristics_table', :partial => 'population_characteristics/table'
						#page['population_characteristic_form'].reset
						#new_row_name = "pop_char_row_" + @population_characteristic.id.to_s
						page.replace_html 'population_characteristic_validation_message', "Saved"
			  	end
				}		
	#if @population_characteristic_data_point.save
        #format.html { redirect_to(@population_characteristic_data_point, :notice => 'Population characteristic data point was successfully created.') }
        #format.xml  { render :xml => @population_characteristic_data_point, :status => :created, :location => @population_characteristic_data_point }
      #else
       # format.html { render :action => "new" }
        #format.xml  { render :xml => @population_characteristic_data_point.errors, :status => :unprocessable_entity }
      #end
    end
  end

  # PUT /population_characteristic_data_points/1
  # PUT /population_characteristic_data_points/1.xml
  def update
    #@population_characteristic_data_point = PopulationCharacteristicDataPoint.find(params[:id])
	PopulationCharacteristicDataPoint.save_data_point_info(params[:study_id], params)
	PopulationCharacteristicDataPoint.save_data_point_totals(params[:study_id], params)
    respond_to do |format|
     # if @population_characteristic_data_point.update_attributes(params[:population_characteristic_data_point])
     #   format.html { redirect_to(@population_characteristic_data_point, :notice => 'Population characteristic data point was successfully updated.') }
     #   format.xml  { head :ok }
     # else
     #   format.html { render :action => "edit" }
     #   format.xml  { render :xml => @population_characteristic_data_point.errors, :status => :unprocessable_entity }
     # end
    end
  end

  # DELETE /population_characteristic_data_points/1
  # DELETE /population_characteristic_data_points/1.xml
  def destroy
    @population_characteristic_data_point = PopulationCharacteristicDataPoint.find(params[:id])
    @population_characteristic_data_point.destroy

    respond_to do |format|
      format.html { redirect_to(population_characteristic_data_points_url) }
      format.xml  { head :ok }
    end
  end
end
