class QualityDimensionFieldsController < ApplicationController
  # GET /quality_dimension_fields
  # GET /quality_dimension_fields.xml
  def index
    @quality_dimension_fields = QualityDimensionField.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quality_dimension_fields }
    end
  end

  # GET /quality_dimension_fields/1
  # GET /quality_dimension_fields/1.xml
  def show
    @quality_dimension_field = QualityDimensionField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quality_dimension_field }
    end
  end

  # GET /quality_dimension_fields/new
  # GET /quality_dimension_fields/new.xml
  def new
    @quality_dimension_field = QualityDimensionField.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quality_dimension_field }
    end
  end

  # GET /quality_dimension_fields/1/edit
  def edit
    @quality_dimension_field = QualityDimensionField.find(params[:id])
	    respond_to do |format|
    	format.js{
    		render :update do |page|
				if !params[:study_id].nil?
					page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/custom_field_edit_form'
				else
				    page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/edit_form'
				end
    		end
  		}
  	end	
  end

  # POST /quality_dimension_fields
  # POST /quality_dimension_fields.xml
  def create
    @quality_dimension_field = QualityDimensionField.new(params[:quality_dimension_field])
respond_to do |format|
	if @quality_dimension_field.save
	    format.js {
		tmpl_id = @quality_dimension_field.template_id
			  	render :update do |page|
						if !params[:study_id].nil?
							@curr_tmpl = StudyTemplate.where(:study_id => session[:study_id]).first
							if !@curr_tmpl.nil?
								@quality_dimension_template_fields = QualityDimensionField.where(:template_id => @curr_tmpl.template_id).all
							else
								@quality_dimension_template_fields = nil
							end
							@quality_dimension_custom_fields = QualityDimensionField.where(:study_id => session[:study_id]).all
							@quality_dimension_data_point = QualityDimensionDataPoint.new
							@study_arms = Arm.where(:study_id => session[:study_id]).all
							page.replace_html 'quality_dimension_fields_table', :partial => 'quality_dimension_data_points/table'
							@quality_dimension_field = QualityDimensionField.new					
							page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/custom_field_form'
						else
							@quality_dimension_fields = QualityDimensionField.where(:template_id => params[:quality_dimension_field][:template_id]).all
							page.replace_html 'quality_dimension_fields_table', :partial => 'quality_dimension_fields/table'
							@quality_dimension_field = QualityDimensionField.new
							page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/form'							
						end																		 
			  	end
				}
	else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @baseline_characteristic_field.errors
			problem_html += "<li>" + i.to_s + " " + @quality_dimension_field.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.js {
			render :update do |page| 
				page.replace_html 'quality_dimension_validation_message', problem_html
				page['quality_dimension_fields_entry'].reset				
			end
		}			
        format.html { render :action => "new" }
        format.xml  { render :xml => @quality_dimension_field.errors, :status => :unprocessable_entity }
      end
	end
  end

  # PUT /quality_dimension_fields/1
  # PUT /quality_dimension_fields/1.xml
  def update
    @quality_dimension_field = QualityDimensionField.find(params[:id])

    respond_to do |format|
      if @quality_dimension_field.update_attributes(params[:quality_dimension_field])
format.js{
			render :update do |page| 
				if !params[:study_id].nil?
					@curr_tmpl = StudyTemplate.where(:study_id => session[:study_id]).first
					if !@curr_tmpl.nil?
						@quality_dimension_template_fields = QualityDimensionField.where(:template_id => @curr_tmpl.template_id).all
					else
						@quality_dimension_template_fields = nil
					end
					@quality_dimension_custom_fields = QualityDimensionField.where(:study_id => session[:study_id]).all
					@quality_dimension_data_point = QualityDimensionDataPoint.new
					@study_arms = Arm.where(:study_id => session[:study_id]).all
					page.replace_html 'quality_dimension_fields_table', :partial => 'quality_dimension_data_points/table'
					@quality_dimension_field = QualityDimensionField.new					
					page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/custom_field_form'
				else
					@quality_dimension_fields = QualityDimensionField.where(:template_id => params[:quality_dimension_field][:template_id]).all
					page.replace_html 'quality_dimension_fields_table', :partial => 'quality_dimension_fields/table'
					@quality_dimension_field = QualityDimensionField.new
					page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/form'
				end	
			end
		}	  
		format.html { redirect_to(@quality_dimension_field, :notice => 'Quality dimension field was successfully updated.') }
		format.xml  { head :ok }
      else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @quality_dimension_field.errors
			problem_html += "<li>" + i.to_s + " " + @quality_dimension_field.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.html {
			render :update do |page| 
				page.replace_html 'quality_dimension_validation_message', problem_html
			end
		}			  
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quality_dimension_field.errors, :status => :unprocessable_entity }
      end
      end
  end

  # DELETE /quality_dimension_fields/1
  # DELETE /quality_dimension_fields/1.xml
  def destroy
    @quality_dimension_field = QualityDimensionField.find(params[:id])
	tmpl_id = @quality_dimension_field.template_id
    @quality_dimension_field.destroy
	@quality_dimension_fields = QualityDimensionField.find(:all, :conditions => {:template_id => tmpl_id})

    respond_to do |format|
	    format.js {
		  render :update do |page|
				if !params[:study_id].nil?
					@curr_tmpl = StudyTemplate.where(:study_id => params[:study_id]).first
					@quality_dimension_template_fields = QualityDimensionField.where(:template_id => @curr_tmpl.template_id).all
					@quality_dimension_custom_fields = QualityDimensionField.where(:study_id => params[:study_id]).all
					@quality_dimension_data_point = QualityDimensionDataPoint.new
					@study_arms = Arm.where(:study_id => params[:study_id]).all				
					page.replace_html 'quality_dimension_fields_table', :partial => 'quality_dimension_data_points/table'	
					@quality_dimension_field = QualityDimensionField.new
					page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/custom_field_form'
				else
					@quality_dimension_fields = QualityDimensionField.where(:template_id => tmpl_id).all				
					page.replace_html 'quality_dimension_fields_table', :partial => 'quality_dimension_fields/table'
					@quality_dimension_field = QualityDimensionField.new
					page.replace_html 'quality_dimension_fields_entry', :partial=>'quality_dimension_fields/form'
				end
		  end
		}
    end
  end
end
