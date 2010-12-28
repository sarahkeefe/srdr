class BaselineCharacteristicSubcategoryFieldsController < ApplicationController
  # GET /baseline_characteristic_subcategory_fields
  # GET /baseline_characteristic_subcategory_fields.xml
  def index
    @baseline_characteristic_subcategory_fields = BaselineCharacteristicSubcategoryField.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @baseline_characteristic_subcategory_fields }
    end
  end

  # GET /baseline_characteristic_subcategory_fields/1
  # GET /baseline_characteristic_subcategory_fields/1.xml
  def show
    @baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @baseline_characteristic_subcategory_field }
    end
  end

  # GET /baseline_characteristic_subcategory_fields/new
  # GET /baseline_characteristic_subcategory_fields/new.xml
  def new
    @baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @baseline_characteristic_subcategory_field }
    end
  end

  # GET /baseline_characteristic_subcategory_fields/1/edit
  def edit
    @baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.find(params[:id])
  end

  # POST /baseline_characteristic_subcategory_fields
  # POST /baseline_characteristic_subcategory_fields.xml
  def create
    @baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.new(params[:baseline_characteristic_subcategory_field])

    respond_to do |format|
      if @baseline_characteristic_subcategory_field.save
        format.html { redirect_to(@baseline_characteristic_subcategory_field, :notice => 'Baseline characteristic subcategory field was successfully created.') }
        format.xml  { render :xml => @baseline_characteristic_subcategory_field, :status => :created, :location => @baseline_characteristic_subcategory_field }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @baseline_characteristic_subcategory_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /baseline_characteristic_subcategory_fields/1
  # PUT /baseline_characteristic_subcategory_fields/1.xml
  def update
    @baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.find(params[:id])

    respond_to do |format|
      if @baseline_characteristic_subcategory_field.update_attributes(params[:baseline_characteristic_subcategory_field])
        format.html { redirect_to(@baseline_characteristic_subcategory_field, :notice => 'Baseline characteristic subcategory field was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @baseline_characteristic_subcategory_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /baseline_characteristic_subcategory_fields/1
  # DELETE /baseline_characteristic_subcategory_fields/1.xml
  def destroy
    @baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.find(params[:id])
    @baseline_characteristic_subcategory_field.destroy

    respond_to do |format|
      format.html { redirect_to(baseline_characteristic_subcategory_fields_url) }
      format.xml  { head :ok }
    end
  end
end
