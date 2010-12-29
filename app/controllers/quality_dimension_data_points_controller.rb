class QualityDimensionDataPointsController < ApplicationController
  # GET /quality_dimension_data_points
  # GET /quality_dimension_data_points.xml
  def index
    @quality_dimension_data_points = QualityDimensionDataPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quality_dimension_data_points }
    end
  end

  # GET /quality_dimension_data_points/1
  # GET /quality_dimension_data_points/1.xml
  def show
    @quality_dimension_data_point = QualityDimensionDataPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quality_dimension_data_point }
    end
  end

  # GET /quality_dimension_data_points/new
  # GET /quality_dimension_data_points/new.xml
  def new
    @quality_dimension_data_point = QualityDimensionDataPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quality_dimension_data_point }
    end
  end

  # GET /quality_dimension_data_points/1/edit
  def edit
    @quality_dimension_data_point = QualityDimensionDataPoint.find(params[:id])
  end

  # POST /quality_dimension_data_points
  # POST /quality_dimension_data_points.xml
  def create
    @quality_dimension_data_point = QualityDimensionDataPoint.new(params[:quality_dimension_data_point])

    respond_to do |format|
      if @quality_dimension_data_point.save
        format.html { redirect_to(@quality_dimension_data_point, :notice => 'Quality dimension data point was successfully created.') }
        format.xml  { render :xml => @quality_dimension_data_point, :status => :created, :location => @quality_dimension_data_point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quality_dimension_data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quality_dimension_data_points/1
  # PUT /quality_dimension_data_points/1.xml
  def update
    @quality_dimension_data_point = QualityDimensionDataPoint.find(params[:id])

    respond_to do |format|
      if @quality_dimension_data_point.update_attributes(params[:quality_dimension_data_point])
        format.html { redirect_to(@quality_dimension_data_point, :notice => 'Quality dimension data point was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quality_dimension_data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quality_dimension_data_points/1
  # DELETE /quality_dimension_data_points/1.xml
  def destroy
    @quality_dimension_data_point = QualityDimensionDataPoint.find(params[:id])
    @quality_dimension_data_point.destroy

    respond_to do |format|
      format.html { redirect_to(quality_dimension_data_points_url) }
      format.xml  { head :ok }
    end
  end
end
