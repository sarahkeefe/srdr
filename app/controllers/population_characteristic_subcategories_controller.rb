class PopulationCharacteristicSubcategoriesController < ApplicationController
  # GET /population_characteristic_subcategories/new
  # GET /population_characteristic_subcategories/new.xml
  def new
    @population_characteristic_subcategory = PopulationCharacteristicSubcategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @population_characteristic_subcategory }
    end
  end

  # GET /population_characteristic_subcategories/1/edit
  def edit
    @population_characteristic_subcategory = PopulationCharacteristicSubcategory.find(params[:id])
  end

  # POST /population_characteristic_subcategories
  # POST /population_characteristic_subcategories.xml
  def create
    @population_characteristic_subcategory = PopulationCharacteristicSubcategory.new(params[:population_characteristic_subcategory])
	
    respond_to do |format|
      if @population_characteristic_subcategory.save
        format.html { redirect_to(@population_characteristic_subcategory, :notice => 'Population characteristic subcategory was successfully created.') }
        format.xml  { render :xml => @population_characteristic_subcategory, :status => :created, :location => @population_characteristic_subcategory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @population_characteristic_subcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /population_characteristic_subcategories/1
  # PUT /population_characteristic_subcategories/1.xml
  def update
    @population_characteristic_subcategory = PopulationCharacteristicSubcategory.find(params[:id])

	
    respond_to do |format|
      if @population_characteristic_subcategory.update_attributes(params[:population_characteristic_subcategory])
        format.html { redirect_to(@population_characteristic_subcategory, :notice => 'Population characteristic subcategory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @population_characteristic_subcategory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /population_characteristic_subcategories/1
  # DELETE /population_characteristic_subcategories/1.xml
  def destroy
    @population_characteristic_subcategory = PopulationCharacteristicSubcategory.find(params[:id])
    @population_characteristic_subcategory.destroy

    respond_to do |format|
      format.html { redirect_to(population_characteristic_subcategories_url) }
      format.xml  { head :ok }
    end
  end
end
