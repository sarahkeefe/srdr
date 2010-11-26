class OutcomeColumnsController < ApplicationController
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
	@outcome_column.outcome_id = params[:outcome_column][:outcome_id]
	@selected_outcome = Outcome.find(params[:outcome_column][:outcome_id])
	@outcome_result = OutcomeResult.new
	@study = Study.find(session[:study_id])
	@study_arms = Arm.where(:study_id => @study.id).all
	if @outcome_column.save
	    @outcome_columns = OutcomeColumn.where(:outcome_id => params[:outcome_column][:outcome_id]).all
		    respond_to do |format|
        format.js {
		      render :update do |page|
				    page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
				    page['outcome_columns_form'].reset
					page.replace_html 'outcome_column_validation_message', ""
		      end
		    }
		#format.html {}
		end
	 else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @outcome_column.errors
				problem_html += "<li>" + i.to_s + " " + @outcome_column.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'outcome_column_validation_message', problem_html
				end
			}
			#format.html { render :action => "new" }
			format.xml  { render :xml => @outcome_column.errors, :status => :unprocessable_entity }
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
