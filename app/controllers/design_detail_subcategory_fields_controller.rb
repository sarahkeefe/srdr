class DesignDetailSubcategoryFieldsController < ApplicationController
  # GET /design_detail_subcategory_fields
  # GET /design_detail_subcategory_fields.xml
  def index
    @design_detail_subcategory_fields = DesignDetailSubcategoryField.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @design_detail_subcategory_fields }
    end
  end

  # GET /design_detail_subcategory_fields/1
  # GET /design_detail_subcategory_fields/1.xml
  def show
    @design_detail_subcategory_field = DesignDetailSubcategoryField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @design_detail_subcategory_field }
    end
  end

  # GET /design_detail_subcategory_fields/new
  # GET /design_detail_subcategory_fields/new.xml
  def new
    @design_detail_subcategory_field = DesignDetailSubcategoryField.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @design_detail_subcategory_field }
    end
  end

  # GET /design_detail_subcategory_fields/1/edit
  def edit
    @design_detail_subcategory_field = DesignDetailSubcategoryField.find(params[:id])
  end

  # POST /design_detail_subcategory_fields
  # POST /design_detail_subcategory_fields.xml
  def create
    @design_detail_subcategory_field = DesignDetailSubcategoryField.new(params[:design_detail_subcategory_field])

    respond_to do |format|
      if @design_detail_subcategory_field.save
        format.html { redirect_to(@design_detail_subcategory_field, :notice => 'Baseline characteristic subcategory field was successfully created.') }
        format.xml  { render :xml => @design_detail_subcategory_field, :status => :created, :location => @design_detail_subcategory_field }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @design_detail_subcategory_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /design_detail_subcategory_fields/1
  # PUT /design_detail_subcategory_fields/1.xml
  def update
    @design_detail_subcategory_field = DesignDetailSubcategoryField.find(params[:id])

    respond_to do |format|
      if @design_detail_subcategory_field.update_attributes(params[:design_detail_subcategory_field])
        format.html { redirect_to(@design_detail_subcategory_field, :notice => 'Baseline characteristic subcategory field was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @design_detail_subcategory_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /design_detail_subcategory_fields/1
  # DELETE /design_detail_subcategory_fields/1.xml
  def destroy
    @design_detail_subcategory_field = DesignDetailSubcategoryField.find(params[:id])
    @design_detail_subcategory_field.destroy

    respond_to do |format|
      format.html { redirect_to(design_detail_subcategory_fields_url) }
      format.xml  { head :ok }
    end
  end
end
