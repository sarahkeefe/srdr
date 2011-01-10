class OutcomeComparisonColumnsController < ApplicationController
  before_filter :require_user
  def new
    @outcome_column = OutcomeComparisonColumn.new

    respond_to do |format|
	format.js{
    	  render :update do |page|
    	  	page.replace_html 'new_comparison_col_entry', :partial => 'outcome_comparison_columns/form'
    	  end
  	 }
	end
  end

  # GET /outcome_comparison_columns/1/edit
  def edit
    @outcome_comparison_column = OutcomeComparisonColumn.find(params[:id])
  end

  # POST /outcome_comparison_columns
  # POST /outcome_comparison_columns.xml
  def create
    @outcome_comparison_column = OutcomeComparisonColumn.new(params[:outcome_comparison_column])

	if @outcome_comparison_column.save
		@template_categorical_columns = OutcomeComparisonColumn.where(:template_id => @outcome_comparison_column.template_id, :outcome_type => "Categorical").all
		@template_continuous_columns = OutcomeComparisonColumn.where(:template_id => @outcome_comparison_column.template_id, :outcome_type => "Continuous").all	
			respond_to do |format|
				format.js {
			      render :update do |page|
					    page.replace_html 'outcome_comparisons_table', :partial => 'outcome_comparison_columns/table', :locals => {:custom_template_id => @outcome_comparison_column.template_id}
					    page['new_outcome_comparison_column'].reset
						page.replace_html 'outcome_comparison_column_validation_message', ""
			      end
			    }
			end
		 else
				problem_html = "<div class='error_message'>The following errors prevented the column from being saved:<br/><ul>"
				for i in @outcome_comparison_column.errors
					problem_html += "<li>" + i.to_s + " " + @outcome_comparison_column.errors[i][0] + "</li>"
				end
				problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
						respond_to do |format|
				format.js {
					render :update do |page| 
						page.replace_html 'outcome_comparison_column_validation_message', problem_html
					end
				}
				format.xml  { render :xml => @outcome_comparison_column.errors, :status => :unprocessable_entity }
			end
 	 end
  end
  
  
  # PUT /outcome_comparison_columns/1
  # PUT /outcome_comparison_columns/1.xml
  def update
    @outcome_comparison_column = OutcomeComparisonColumn.find(params[:id])

    respond_to do |format|
      if @outcome_comparison_column.update_attributes(params[:outcome_comparison_column])
        format.html { redirect_to(@outcome_comparison_column, :notice => 'Outcome comparison column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_comparison_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_comparison_columns/1
  # DELETE /outcome_comparison_columns/1.xml
  def destroy
    @outcome_comparison_column = OutcomeComparisonColumn.find(params[:id])
    @outcome_comparison_column.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_comparison_columns_url) }
      format.xml  { head :ok }
    end
  end
end
