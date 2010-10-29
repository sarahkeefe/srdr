class PopulationCharacteristicsController < ApplicationController
  # GET /population_characteristics
  # GET /population_characteristics.xml
  def index
    @population_characteristics = PopulationCharacteristic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @population_characteristics }
    end
  end

  # GET /population_characteristics/1
  # GET /population_characteristics/1.xml
  def show
    @population_characteristic = PopulationCharacteristic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @population_characteristic }
    end
  end

  # GET /population_characteristics/new
  # GET /population_characteristics/new.xml
  def new
    @population_characteristic = PopulationCharacteristic.new
	@study = Study.find(params[:study_id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @population_characteristic }
    end
  end

  # GET /population_characteristics/1/edit
  def edit
    @population_characteristic = PopulationCharacteristic.find(params[:id])
  end

  # POST /population_characteristics
  # POST /population_characteristics.xml
  def create
    @population_characteristic = PopulationCharacteristic.new(params[:population_characteristic])
	  @study = Study.find(session[:study_id])
    respond_to do |format|
	if !PopulationCharacteristic.has_duplicates(@population_characteristic.category_title, @population_characteristic.subcategory, @population_characteristic.study_id) && @population_characteristic.save
	  @population_characteristics = PopulationCharacteristic.find(:all, :conditions => {:study_id => session[:study_id]}, :order => :category_title)
	  @population_characteristics.sort_by(&:category_title)

	  @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})
        format.js {
		  render :update do |page|
				page.replace_html 'population_characteristics_table', :partial => 'population_characteristics/table'
		  end
		}
	else
        format.html { render :action => "new" }
        format.xml  { render :xml => @population_characteristic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /population_characteristics/1
  # PUT /population_characteristics/1.xml
  def update
    @population_characteristic = PopulationCharacteristic.find(params[:id])

    respond_to do |format|
      if @population_characteristic.update_attributes(params[:population_characteristic])
        format.html { redirect_to(@population_characteristic, :notice => 'Population characteristic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @population_characteristic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /population_characteristics/1
  # DELETE /population_characteristics/1.xml
  def destroy
    @population_characteristic = PopulationCharacteristic.find(params[:id])
    @population_characteristic.destroy
	  @population_characteristics = PopulationCharacteristic.find(:all, :conditions => {:study_id => session[:study_id]}, :order => :category_title)
	  @population_characteristics.sort_by(&:category_title)

	  @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})
    respond_to do |format|
	    format.js {
		  render :update do |page|
				page.replace_html 'population_characteristics_table', :partial => 'population_characteristics/table'
		  end
		}
      format.html { redirect_to(population_characteristics_url) }
      format.xml  { head :ok }
    end
  end
end
