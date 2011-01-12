class DesignDetailSubcategoryDataPointsController < ApplicationController
  # GET /design_detail_subcategory_data_points
  # GET /design_detail_subcategory_data_points.xml
  def index
    @design_detail_subcategory_data_points = DesignDetailSubcategoryDataPoint.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @design_detail_subcategory_data_points }
    end
  end

  # GET /design_detail_subcategory_data_points/1
  # GET /design_detail_subcategory_data_points/1.xml
  def show
    @design_detail_subcategory_data_point = DesignDetailSubcategoryDataPoint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @design_detail_subcategory_data_point }
    end
  end

  # GET /design_detail_subcategory_data_points/new
  # GET /design_detail_subcategory_data_points/new.xml
  def new
    @design_detail_subcategory_data_point = DesignDetailSubcategoryDataPoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @design_detail_subcategory_data_point }
    end
  end

  # GET /design_detail_subcategory_data_points/1/edit
  def edit
    @design_detail_subcategory_data_point = DesignDetailSubcategoryDataPoint.find(params[:id])
  end

  # POST /design_detail_subcategory_data_points
  # POST /design_detail_subcategory_data_points.xml
  def create
    @design_detail_subcategory_data_point = DesignDetailSubcategoryDataPoint.new(params[:design_detail_subcategory_data_point])

    respond_to do |format|
      if @design_detail_subcategory_data_point.save
        format.html { redirect_to(@design_detail_subcategory_data_point, :notice => 'Baseline characteristic subcategory data point was successfully created.') }
        format.xml  { render :xml => @design_detail_subcategory_data_point, :status => :created, :location => @design_detail_subcategory_data_point }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @design_detail_subcategory_data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /design_detail_subcategory_data_points/1
  # PUT /design_detail_subcategory_data_points/1.xml
  def update
    @design_detail_subcategory_data_point = DesignDetailSubcategoryDataPoint.find(params[:id])

    respond_to do |format|
      if @design_detail_subcategory_data_point.update_attributes(params[:design_detail_subcategory_data_point])
        format.html { redirect_to(@design_detail_subcategory_data_point, :notice => 'Baseline characteristic subcategory data point was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @design_detail_subcategory_data_point.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /design_detail_subcategory_data_points/1
  # DELETE /design_detail_subcategory_data_points/1.xml
  def destroy
    @design_detail_subcategory_data_point = DesignDetailSubcategoryDataPoint.find(params[:id])
    @design_detail_subcategory_data_point.destroy

    respond_to do |format|
      format.html { redirect_to(design_detail_subcategory_data_points_url) }
      format.xml  { head :ok }
    end
  end
end
