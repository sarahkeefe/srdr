class BaselineCharacteristicSubcategoryDataPointsController < ApplicationController
  # GET /baseline_characteristic_subcategory_data_points
  # GET /baseline_characteristic_subcategory_data_points.xml
  def index
    @baseline_characteristic_subcategory_data_points = BaselineCharacteristicSubcategoryDataPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @baseline_characteristic_subcategory_data_points }
    end
  end

  # GET /baseline_characteristic_subcategory_data_points/1
  # GET /baseline_characteristic_subcategory_data_points/1.xml
  def show
    @baseline_characteristic_subcategory_data_point = BaselineCharacteristicSubcategoryDataPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @baseline_characteristic_subcategory_data_point }
    end
  end

  # GET /baseline_characteristic_subcategory_data_points/new
  # GET /baseline_characteristic_subcategory_data_points/new.xml
  def new
    @baseline_characteristic_subcategory_data_point = BaselineCharacteristicSubcategoryDataPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @baseline_characteristic_subcategory_data_point }
    end
  end

  # GET /baseline_characteristic_subcategory_data_points/1/edit
  def edit
    @baseline_characteristic_subcategory_data_point = BaselineCharacteristicSubcategoryDataPoint.find(params[:id])
  end

  # POST /baseline_characteristic_subcategory_data_points
  # POST /baseline_characteristic_subcategory_data_points.xml
  def create
    @baseline_characteristic_subcategory_data_point = BaselineCharacteristicSubcategoryDataPoint.new(params[:baseline_characteristic_subcategory_data_point])

    respond_to do |format|
      if @baseline_characteristic_subcategory_data_point.save
        format.html { redirect_to(@baseline_characteristic_subcategory_data_point, :notice => 'Baseline characteristic subcategory data point was successfully created.') }
        format.xml  { render :xml => @baseline_characteristic_subcategory_data_point, :status => :created, :location => @baseline_characteristic_subcategory_data_point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @baseline_characteristic_subcategory_data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /baseline_characteristic_subcategory_data_points/1
  # PUT /baseline_characteristic_subcategory_data_points/1.xml
  def update
    @baseline_characteristic_subcategory_data_point = BaselineCharacteristicSubcategoryDataPoint.find(params[:id])

    respond_to do |format|
      if @baseline_characteristic_subcategory_data_point.update_attributes(params[:baseline_characteristic_subcategory_data_point])
        format.html { redirect_to(@baseline_characteristic_subcategory_data_point, :notice => 'Baseline characteristic subcategory data point was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @baseline_characteristic_subcategory_data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /baseline_characteristic_subcategory_data_points/1
  # DELETE /baseline_characteristic_subcategory_data_points/1.xml
  def destroy
    @baseline_characteristic_subcategory_data_point = BaselineCharacteristicSubcategoryDataPoint.find(params[:id])
    @baseline_characteristic_subcategory_data_point.destroy

    respond_to do |format|
      format.html { redirect_to(baseline_characteristic_subcategory_data_points_url) }
      format.xml  { head :ok }
    end
  end
end
