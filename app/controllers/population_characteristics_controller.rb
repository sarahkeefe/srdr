class PopulationCharacteristicsController < ApplicationController
  # GET /population_characteristics/new
  # GET /population_characteristics/new.xml
  def new
    @population_characteristic = PopulationCharacteristic.new
	@population_characteristic_data_point = PopulationCharacteristicDataPoint.new
	@study = Study.find(session[:study_id])
    respond_to do |format|
			format.js{
    	  render :update do |page|
    	  	page.replace_html 'population_characteristic_entry', :partial => 'population_characteristics/form'
    	  end
  	  }	
      format.html # new.html.erb
      format.xml  { render :xml => @population_characteristic }
    end
  end

  # GET /population_characteristics/1/edit
  def edit
    @population_characteristic = PopulationCharacteristic.find(params[:id])
	@study = Study.find(session[:study_id])
    respond_to do |format|
    	format.js{
    		render :update do |page|
    			page.replace_html 'population_characteristic_entry', :partial=>'population_characteristics/edit_form'
    		end
  		}
  	end	
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
			  @population_characteristic_data_point = PopulationCharacteristicDataPoint.new
			  @population_characteristic.save
			  @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})
	      format.js {
			  	render :update do |page|
						page.replace_html 'population_characteristics_table', :partial => 'population_characteristics/table'
						page['population_characteristic_form'].reset
						new_row_name = "pop_char_row_" + @population_characteristic.id.to_s
						page.replace_html 'population_characteristic_validation_message', ""																						 
			  	end
				}
	else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @population_characteristic.errors
			problem_html += "<li>" + i.to_s + " " + @population_characteristic.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.html {
			render :update do |page| 
				page.replace_html 'population_characteristic_validation_message', problem_html
				page['population_characteristic_form'].reset				
			end
		}			
        format.html { render :action => "new" }
        format.xml  { render :xml => @population_characteristic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /population_characteristics/1
  # PUT /population_characteristics/1.xml
  def update
    @population_characteristic = PopulationCharacteristic.find(params[:id])
	@study = Study.find(session[:study_id])
    respond_to do |format|
	if @population_characteristic.update_attributes(params[:population_characteristic])
		@population_characteristics = PopulationCharacteristic.find(:all, :conditions => {:study_id => session[:study_id]}, :order => :category_title)
		@population_characteristics.sort_by(&:category_title)		
		@population_characteristic_data_point = PopulationCharacteristicDataPoint.new
		@study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	  
		format.js{
			render :update do |page|
			    page.replace_html 'population_characteristics_table', :partial => 'population_characteristics/table'
				new_row_name = "pop_char_row_" + @population_characteristic.id.to_s					  
				page.replace_html 'population_characteristic_validation_message', ""						
			end
		}	  
		format.html { redirect_to(@population_characteristic, :notice => 'Population characteristic was successfully updated.') }
		format.xml  { head :ok }
      else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @population_characteristic.errors
			problem_html += "<li>" + i.to_s + " " + @population_characteristic.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.html {
			render :update do |page| 
				page.replace_html 'population_characteristic_validation_message', problem_html
			end
		}			  
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
		@population_characteristic_data_point = PopulationCharacteristicDataPoint.new
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
  
 def addtotals 
end 
end
