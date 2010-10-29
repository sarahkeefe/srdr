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
	@study_arms = Study.get_arms(session[:study_id])
	@study_pop_chars = Study.get_attributes(session[:study_id])
	
	for a in @study_arms
		for p in @study_pop_chars
			if !params["arm" + a.id.to_s + "attribute"][p.id.to_s].nil?
				@existing = PopulationCharacteristicDataPoint.where(:arm_id => a.id, :attribute_id => p.id, :is_total => false).all
				if @existing.length > 0
					for i in @existing
						if i.value != params["arm" + a.id.to_s + "attribute"][p.id.to_s]
							i.value = params["arm" + a.id.to_s + "attribute"][p.id.to_s]
							i.save
						else
						end
					end
				else
					@population_characteristic_data_point = PopulationCharacteristicDataPoint.new(params[:population_characteristic_data_point])
					@population_characteristic_data_point.arm_id = a.id
					@population_characteristic_data_point.attribute_id = p.id
					@population_characteristic_data_point.value = params["arm" + a.id.to_s + "attribute"][p.id.to_s]
					@population_characteristic_data_point.is_total = false
					@population_characteristic_data_point.save
				end
			end
		end
	end

		for p in @study_pop_chars	
			if !params["attribute_total"][p.id.to_s].nil?
				@existing = PopulationCharacteristicDataPoint.where(:arm_id => -1, :attribute_id => p.id, :is_total => true).all
				if @existing.length > 0
					for i in @existing
						if i.value != params["attribute_total"][p.id.to_s]
							i.value = params["attribute_total"][p.id.to_s]
							i.save
						else
						end
					end
				else
					@population_characteristic_data_point = PopulationCharacteristicDataPoint.new(params[:population_characteristic_data_point])
					@population_characteristic_data_point.arm_id = -1
					@population_characteristic_data_point.attribute_id = p.id
					@population_characteristic_data_point.value = params["attribute_total"][p.id.to_s]
					@population_characteristic_data_point.is_total = true
					@population_characteristic_data_point.save
				end
			end
		end			
	
    respond_to do |format|
      if @population_characteristic_data_point.save
        format.html { redirect_to(@population_characteristic_data_point, :notice => 'Population characteristic data point was successfully created.') }
        format.xml  { render :xml => @population_characteristic_data_point, :status => :created, :location => @population_characteristic_data_point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @population_characteristic_data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /population_characteristic_data_points/1
  # PUT /population_characteristic_data_points/1.xml
  def update
    @population_characteristic_data_point = PopulationCharacteristicDataPoint.find(params[:id])

    respond_to do |format|
      if @population_characteristic_data_point.update_attributes(params[:population_characteristic_data_point])
        format.html { redirect_to(@population_characteristic_data_point, :notice => 'Population characteristic data point was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @population_characteristic_data_point.errors, :status => :unprocessable_entity }
      end
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
