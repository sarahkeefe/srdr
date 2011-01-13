class DesignDetailFieldsController < ApplicationController
  # GET /design_detail_fields
  # GET /design_detail_fields.xml
  def index
    @design_detail_fields = DesignDetailField.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @design_detail_fields }
    end
  end

  # GET /design_detail_fields/1
  # GET /design_detail_fields/1.xml
  def show
    @design_detail_field = DesignDetailField.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @design_detail_field }
    end
  end

  # GET /design_detail_fields/new
  # GET /design_detail_fields/new.xml
  def new
    @design_detail_field = DesignDetailField.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @design_detail_field }
      
      # If a user has added custom fields and is clearing an edit form, this will set 
      # the form back to its original state.
      format.js {  
        render :update do |page|
       		page.replace_html 'population_characteristic_entry', :partial=>'design_detail_fields/custom_field_form' 	
        end
      }
    end
  end

  # GET /design_detail_fields/1/edit
  def edit
    @design_detail_field = DesignDetailField.find(params[:id])
	    respond_to do |format|
    	format.js{
    		render :update do |page|
					if !params[:study_id].nil?
						page.replace_html 'population_characteristic_entry', :partial=>'design_detail_fields/custom_field_edit_form'
					else
					  page.replace_html 'design_detail_fields_entry', :partial=>'design_detail_fields/edit_form'
					end
    		end
  		}
  	end	
  end

  # POST /design_detail_fields
  # POST /design_detail_fields.xml
  def create
    @design_detail_field = DesignDetailField.new(params[:design_detail_field])
	study_id = params[:design_detail_field][:study_id]
respond_to do |format|
	if @design_detail_field.save
	tmpl_id = @design_detail_field.template_id
	      format.js {
			  	render :update do |page|

						if !study_id.nil?
							@curr_tmpl = StudyTemplate.where(:study_id => study_id).first
							if !@curr_tmpl.nil?
								@design_detail_template_fields = DesignDetailField.where(:template_id => @curr_tmpl.template_id).all
							else
								@design_detail_template_fields = nil
							end
							@design_detail_custom_fields = DesignDetailField.where(:study_id => study_id).all
							@design_detail_data_point = DesignDetailDataPoint.new
							@study_arms = Arm.where(:study_id => study_id).all
							page.replace_html 'population_characteristics_table', :partial => 'design_detail_data_points/table'
							new_row_name = "pop_char_row_" + @design_detail_field.id.to_s	
							@design_detail_field = DesignDetailField.new					
							page.replace_html 'population_characteristic_entry', :partial=>'design_detail_fields/custom_field_form'							
						else
							@design_detail_fields = DesignDetailField.where(:template_id => tmpl_id).all
							page.replace_html 'design_detail_fields_table', :partial => 'design_detail_fields/table'
							new_row_name = "bcf_row_" + @design_detail_field.id.to_s
							@design_detail_field = DesignDetailField.new
							page.replace_html 'design_detail_fields_entry', :partial=>'design_detail_fields/form'							
						end																		 
			  	end
				}
	else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @design_detail_field.errors
			problem_html += "<li>" + i.to_s + " " + @design_detail_field.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.html {
			render :update do |page| 
				page.replace_html 'population_characteristic_validation_message', problem_html
				page['population_characteristic_form'].reset				
			end
		}			
        format.html { render :action => "new" }
        format.xml  { render :xml => @design_detail_field.errors, :status => :unprocessable_entity }
      end
    end
	
  end

  # PUT /design_detail_fields/1
  # PUT /design_detail_fields/1.xml
  def update
    @design_detail_field = DesignDetailField.find(params[:id])
	tmpl_id = @design_detail_field.template_id
	study_id = params[:design_detail_field][:study_id]
    respond_to do |format|
	if @design_detail_field.update_attributes(params[:design_detail_field])
		format.js{
			render :update do |page| 
				if !study_id.nil?
					@curr_tmpl = StudyTemplate.where(:study_id => study_id).first
					if !@curr_tmpl.nil?
						@design_detail_template_fields = DesignDetailField.where(:template_id => @curr_tmpl.template_id).all
					else
						@design_detail_template_fields = nil
					end
					@design_detail_custom_fields = DesignDetailField.where(:study_id => study_id).all
					@design_detail_data_point = DesignDetailDataPoint.new
					@study_arms = Arm.where(:study_id => study_id).all
					page.replace_html 'population_characteristics_table', :partial => 'design_detail_data_points/table'
					@design_detail_field = DesignDetailField.new					
					page.replace_html 'population_characteristic_entry', :partial=>'design_detail_fields/custom_field_form'
				else
					@design_detail_fields = DesignDetailField.where(:template_id => params[:design_detail_field][:template_id]).all
					page.replace_html 'design_detail_fields_table', :partial => 'design_detail_fields/table'
					@design_detail_field = DesignDetailField.new
					page.replace_html 'design_detail_fields_entry', :partial=>'design_detail_fields/form'
				end	
			end
		}	  
		format.html { redirect_to(@design_detail_field, :notice => 'Baseline characteristic field was successfully updated.') }
		format.xml  { head :ok }
      else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @design_detail_field.errors
			problem_html += "<li>" + i.to_s + " " + @design_detail_field.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		format.html {
			render :update do |page| 
				#page.replace_html 'population_characteristic_validation_message', problem_html
			end
		}			  
        format.html { render :action => "edit" }
        format.xml  { render :xml => @design_detail_field.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /design_detail_fields/1
  # DELETE /design_detail_fields/1.xml
  def destroy
    @design_detail_field = DesignDetailField.find(params[:id])
	  tmpl_id = @design_detail_field.template_id
    @design_detail_field.destroy
	  @design_detail_fields = DesignDetailField.find(:all, :conditions => {:template_id => tmpl_id})

    respond_to do |format|
	    format.js {
		  render :update do |page|
				if !params[:study_id].nil?
					@curr_tmpl = StudyTemplate.where(:study_id => session[:study_id]).first
					@design_detail_template_fields = []
					unless @curr_tmpl.nil?
						@design_detail_template_fields = DesignDetailField.where(:template_id => @curr_tmpl.template_id).all
					end
					@design_detail_custom_fields = DesignDetailField.where(:study_id => session[:study_id]).all
					@design_detail_data_point = DesignDetailDataPoint.new
					@study_arms = Arm.where(:study_id => session[:study_id]).all				
					page.replace_html 'population_characteristics_table', :partial => 'design_detail_data_points/table'	
					@design_detail_field = DesignDetailField.new
					page.replace_html 'population_characteristic_entry', :partial=>'design_detail_fields/custom_field_form'
				else
					@design_detail_fields = DesignDetailField.where(:template_id => tmpl_id).all				
					page.replace_html 'design_detail_fields_table', :partial => 'design_detail_fields/table'
					@design_detail_field = DesignDetailField.new
					page.replace_html 'design_detail_fields_entry', :partial=>'design_detail_fields/form', :locals => {:custom_template_id => tmpl_id}
				end
		  end
		}
    end
end


end
