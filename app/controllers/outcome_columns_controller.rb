class OutcomeColumnsController < ApplicationController
  before_filter :require_user
  def new
    @outcome_column = OutcomeColumn.new

    respond_to do |format|
	format.js{
    	  render :update do |page|
    	  	page.replace_html 'new_col_entry', :partial => 'outcome_columns/form'
    	  end
  	 }
	end
  end

  def edit
    @outcome_column = OutcomeColumn.find(params[:id])
  end 
 
  # POST /outcome_columns
  # POST /outcome_columns.xml
  def create
    @outcome_column = OutcomeColumn.new(params[:outcome_column])
		@outcome_column.outcome_id = params[:outcome_id]
		@outcome_column.timepoint_id = params[:timepoint_id]
		@outcome_column.subgroup_id = params[:subgroup_id]
		@study = Study.find(session[:study_id])
	
		@selected_outcome_object = Outcome.find(params[:outcome_id])
		@selected_subgroup = params[:subgroup_id]
		@selected_timepoint = params[:timepoint_id]
		@selected_outcome_object_results =OutcomeResult.get_selected_outcome_results(params[:outcome_id], params[:subgroup_id], params[:timepoint_id])
		@study_arms = Arm.where(:study_id => session[:study_id]).all
	
		# the following few lines are used by the footnote generations
		# gather any footnotes for the first selections
		@footnotes = Footnote.where(:study_id=>session[:study_id], :outcome_id=>@selected_outcome_object.id,
															  :subgroup_id=>@selected_subgroup, :timepoint_id=>@selected_timepoint)
		@study_arm_ids = @study_arms.collect{|arm| arm.id}
		@study_arm_ids = @study_arm_ids.to_json	  
															  
		if @outcome_column.save
			@outcome_columns = OutcomeColumn.where(:outcome_id => params[:outcome_id], :subgroup_id => params[:subgroup_id], :timepoint_id => params[:timepoint_id]).all
			respond_to do |format|
				format.js {
			      render :update do |page|
					    page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
					    page['new_outcome_column'].reset
						page.call "Custom.init"
						page.replace_html 'outcome_column_validation_message', ""
			      end
			    }
			end
		 else
				problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
				for i in @outcome_column.errors
					problem_html += "<li>" + i.to_s + " " + @outcome_column.errors[i][0] + "</li>"
				end
				problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
						respond_to do |format|
				format.js {
					render :update do |page| 
						page.replace_html 'outcome_column_validation_message', problem_html
					end
				}
				format.xml  { render :xml => @outcome_column.errors, :status => :unprocessable_entity }
			end
 	 end
  end

  # PUT /outcome_columns/1
  # PUT /outcome_columns/1.xml
  def update
    @outcome_column = OutcomeColumn.find(params[:id])

    respond_to do |format|
      if @outcome_column.update_attributes(params[:outcome_column])
        format.html { redirect_to(@outcome_column, :notice => 'Outcome column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_columns/1
  # DELETE /outcome_columns/1.xml
  def destroy
    @outcome_column = OutcomeColumn.find(params[:id])
    @outcome_column.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_columns_url) }
      format.xml  { head :ok }
    end
  end
end
