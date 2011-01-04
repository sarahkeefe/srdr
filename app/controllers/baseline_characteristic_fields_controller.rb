class BaselineCharacteristicFieldsController < ApplicationController
  # GET /baseline_characteristic_fields
  # GET /baseline_characteristic_fields.xml
  def index
    @baseline_characteristic_fields = BaselineCharacteristicField.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @baseline_characteristic_fields }
    end
  end

  # GET /baseline_characteristic_fields/1
  # GET /baseline_characteristic_fields/1.xml
  def show
    @baseline_characteristic_field = BaselineCharacteristicField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @baseline_characteristic_field }
    end
  end

  # GET /baseline_characteristic_fields/new
  # GET /baseline_characteristic_fields/new.xml
  def new
    @baseline_characteristic_field = BaselineCharacteristicField.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @baseline_characteristic_field }
    end
  end

  # GET /baseline_characteristic_fields/1/edit
  def edit
    @baseline_characteristic_field = BaselineCharacteristicField.find(params[:id])
	    respond_to do |format|
    	format.js{
    		render :update do |page|
				if !params[:study_id].nil?
					page.replace_html 'population_characteristic_entry', :partial=>'baseline_characteristic_fields/custom_field_form'
				else
				    page.replace_html 'baseline_characteristic_fields_entry', :partial=>'baseline_characteristic_fields/edit_form'
				end
    		end
  		}
  	end	
  end

  # POST /baseline_characteristic_fields
  # POST /baseline_characteristic_fields.xml
  def create
    @baseline_characteristic_field = BaselineCharacteristicField.new(params[:baseline_characteristic_field])
respond_to do |format|
	if @baseline_characteristic_field.save
	tmpl_id = @baseline_characteristic_field.template_id
	      format.js {
			  	render :update do |page|
						if !params[:study_id].nil?
							@curr_tmpl = StudyTemplate.where(:study_id => params[:study_id]).first
							if !@curr_tmpl.nil?
								@baseline_characteristic_template_fields = BaselineCharacteristicField.where(:template_id => @curr_tmpl.template_id).all
							else
								@baseline_characteristic_template_fields = nil
							end
							@baseline_characteristic_custom_fields = BaselineCharacteristicField.where(:study_id => params[:study_id]).all
							@baseline_characteristic_data_point = BaselineCharacteristicDataPoint.new
							@study_arms = Arm.where(:study_id => params[:study_id]).all
							page.replace_html 'population_characteristics_table', :partial => 'baseline_characteristic_data_points/table'
							new_row_name = "pop_char_row_" + @baseline_characteristic_field.id.to_s	
							@baseline_characteristic_field = BaselineCharacteristicField.new					
							page.replace_html 'population_characteristic_entry', :partial=>'baseline_characteristic_fields/custom_field_form'							
						else
							@baseline_characteristic_fields = BaselineCharacteristicField.where(:template_id => tmpl_id).all
							page.replace_html 'baseline_characteristic_fields_table', :partial => 'baseline_characteristic_fields/table'
							new_row_name = "bcf_row_" + @baseline_characteristic_field.id.to_s
							@baseline_characteristic_field = BaselineCharacteristicField.new
							page.replace_html 'baseline_characteristic_fields_entry', :partial=>'baseline_characteristic_fields/form'							
						end																		 
			  	end
				}
	else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @baseline_characteristic_field.errors
			problem_html += "<li>" + i.to_s + " " + @baseline_characteristic_field.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.html {
			render :update do |page| 
				page.replace_html 'population_characteristic_validation_message', problem_html
				page['population_characteristic_form'].reset				
			end
		}			
        format.html { render :action => "new" }
        format.xml  { render :xml => @baseline_characteristic_field.errors, :status => :unprocessable_entity }
      end
    end
	
  end

  # PUT /baseline_characteristic_fields/1
  # PUT /baseline_characteristic_fields/1.xml
  def update
    @baseline_characteristic_field = BaselineCharacteristicField.find(params[:id])
	tmpl_id = @baseline_characteristic_field.template_id
    respond_to do |format|
	if @baseline_characteristic_field.update_attributes(params[:baseline_characteristic_field])
		#@baseline_characteristic_custom_fields = BaselineCharacteristicField.where(:study_id => session[:study_id]).all
		#@baseline_characteristic_template_fields = BaselineCharacteristicField.where(:template_id => tmpl_id).all
		format.js{
			render :update do |page| 
				if !params[:study_id].nil?
					@curr_tmpl = StudyTemplate.where(:study_id => session[:study_id]).first
					if !@curr_tmpl.nil?
						@baseline_characteristic_template_fields = BaselineCharacteristicField.where(:template_id => @curr_tmpl.template_id).all
					else
						@baseline_characteristic_template_fields = nil
					end
					@baseline_characteristic_custom_fields = BaselineCharacteristicField.where(:study_id => session[:study_id]).all
					@baseline_characteristic_data_point = BaselineCharacteristicDataPoint.new
					@study_arms = Arm.where(:study_id => session[:study_id]).all
					page.replace_html 'population_characteristics_table', :partial => 'baseline_characteristic_data_points/table'
					@baseline_characteristic_field = BaselineCharacteristicField.new					
					page.replace_html 'population_characteristic_entry', :partial=>'baseline_characteristic_fields/custom_field_form'
				else
					@baseline_characteristic_fields = BaselineCharacteristicField.where(:template_id => params[:baseline_characteristic_field][:template_id]).all
					page.replace_html 'baseline_characteristic_fields_table', :partial => 'baseline_characteristic_fields/table'
					@baseline_characteristic_field = BaselineCharacteristicField.new
					page.replace_html 'baseline_characteristic_fields_entry', :partial=>'baseline_characteristic_fields/form'
				end	
			end
		}	  
		format.html { redirect_to(@baseline_characteristic_field, :notice => 'Baseline characteristic field was successfully updated.') }
		format.xml  { head :ok }
      else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @baseline_characteristic_field.errors
			problem_html += "<li>" + i.to_s + " " + @baseline_characteristic_field.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.html {
			render :update do |page| 
				#page.replace_html 'population_characteristic_validation_message', problem_html
			end
		}			  
        format.html { render :action => "edit" }
        format.xml  { render :xml => @baseline_characteristic_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /baseline_characteristic_fields/1
  # DELETE /baseline_characteristic_fields/1.xml
  def destroy
    @baseline_characteristic_field = BaselineCharacteristicField.find(params[:id])
	tmpl_id = @baseline_characteristic_field.template_id
    @baseline_characteristic_field.destroy
	@baseline_characteristic_fields = BaselineCharacteristicField.find(:all, :conditions => {:template_id => tmpl_id})

    respond_to do |format|
	    format.js {
		  render :update do |page|
				if !params[:study_id].nil?
					@curr_tmpl = StudyTemplate.where(:study_id => params[:study_id]).first
					@baseline_characteristic_template_fields = BaselineCharacteristicField.where(:template_id => @curr_tmpl.template_id).all
					@baseline_characteristic_custom_fields = BaselineCharacteristicField.where(:study_id => params[:study_id]).all
					@baseline_characteristic_data_point = BaselineCharacteristicDataPoint.new
					@study_arms = Arm.where(:study_id => params[:study_id]).all				
					page.replace_html 'population_characteristics_table', :partial => 'baseline_characteristic_data_points/table'	
					@baseline_characteristic_field = BaselineCharacteristicField.new
					page.replace_html 'population_characteristic_entry', :partial=>'baseline_characteristic_fields/custom_field_form'
				else
					@baseline_characteristic_fields = BaselineCharacteristicField.where(:template_id => tmpl_id).all				
					page.replace_html 'baseline_characteristic_fields_table', :partial => 'baseline_characteristic_fields/table'
					@baseline_characteristic_field = BaselineCharacteristicField.new
					page.replace_html 'baseline_characteristic_fields_entry', :partial=>'baseline_characteristic_fields/form'
				end
		  end
		}
    end
end


end
