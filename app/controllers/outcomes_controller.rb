class OutcomesController < ApplicationController
  # GET /outcomes/new
  # GET /outcomes/new.xml
  def new
    @outcome = Outcome.new
	  @outcome_timepoint = OutcomeTimepoint.new
	  @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	
    respond_to do |format|
      format.js{
    	  render :update do |page|
    	  	page.replace_html 'new_outcome_entry', :partial => 'outcomes/form'
    	  end
  	  }
    	format.html # new.html.erb
      format.xml  { render :xml => @outcome }
    end
  end

  # GET /outcomes/1/edit
  def edit
    @outcome = Outcome.find(params[:id])
    @study_arms = Arm.find(:all, :select=>[:id,:title,:num_participants], :conditions => {:study_id => session[:study_id]})	

   respond_to do |format|
    format.js {
		    render :update do |page|
				  page.replace_html 'new_outcome_entry', :partial => 'outcomes/edit_form'
		    end
		  }
		end
  end

  # POST /outcomes
  # POST /outcomes.xml
  def create
    @outcome = Outcome.new(params[:outcome])
	@outcome.study_id = session[:study_id]
	@outcome.save
	@study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	
	  
    respond_to do |format|
      if @outcome.save
		    @outcomes = Outcome.find(:all, :conditions => {:study_id => session[:study_id]})
		    @outcome_timepoints = OutcomeTimepoint.where(:outcome_id => @outcome.id).all
		    @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	  
        format.js {
		      render :update do |page|
						page.replace_html 'outcomes_table', :partial => 'outcomes/table'
						page['new_outcome_form'].reset
						new_outcome_row = "outcome_" + @outcome.id.to_s
						page[new_outcome_row].visual_effect :highlight
					page.replace_html 'outcome_validation_message', ""						
		  		end
				}
	else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @outcome.errors
				problem_html += "<li>" + i.to_s + " " + @outcome.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'outcome_validation_message', problem_html
				end
			}	
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcomes/1
  # PUT /outcomes/1.xml
  def update
    @outcome = Outcome.find(params[:id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})		
	
    respond_to do |format|
      if @outcome.update_attributes(params[:outcome])
		    @outcomes = Outcome.find(:all, :conditions => {:study_id => session[:study_id]})

        format.js{
        	render :update do |page|
						page.replace_html 'outcomes_table', :partial => 'outcomes/table'
						updated_row = "outcome_" + @outcome.id.to_s
						page[updated_row].visual_effect :highlight
					page.replace_html 'outcome_validation_message', ""						
		  		end  
        }
      	format.html { redirect_to(@outcome, :notice => 'Outcome was successfully updated.') }
        format.xml  { head :ok }
      else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @outcome.errors
				problem_html += "<li>" + i.to_s + " " + @outcome.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'outcome_validation_message', problem_html
				end
			}		  
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcomes/1
  # DELETE /outcomes/1.xml
  def destroy
    @outcome = Outcome.find(params[:id])
	@outcome_tps = OutcomeTimepoint.where(:outcome_id => @outcome.id).all
	@outcome_subs = OutcomeSubgroup.where(:outcome_id => @outcome.id).all
	@outcome_columns = OutcomeColumn.where(:outcome_id => @outcome.id).all
	@outcome_column_vals = OutcomeColumnValue.where(:outcome_id => @outcome.id).all
	@outcome_results = OutcomeResult.where(:outcome_id => @outcome.id).all
    @outcome.destroy
	for i in @outcome_tps
		i.destroy
	end
	for i in @outcome_subs
		i.destroy
	end
	for i in @outcome_columns
		i.destroy
	end	
	for i in @outcome_column_vals
		i.destroy
	end	
	for i in @outcome_results
		i.destroy
	end	
    respond_to do |format|
	  @outcomes = Outcome.find(:all, :conditions => {:study_id => session[:study_id]})
		@study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	  
        format.js {
		  render :update do |page|
				page.replace_html 'outcomes_table', :partial => 'outcomes/table'
		  end
		}
    end
  end
end
