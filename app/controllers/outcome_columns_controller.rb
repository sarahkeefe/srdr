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

	if @outcome_column.save
		@template_categorical_columns = OutcomeColumn.where(:template_id => @outcome_column.template_id, :outcome_type => "Categorical").all
		@template_continuous_columns = OutcomeColumn.where(:template_id => @outcome_column.template_id, :outcome_type => "Continuous").all	
			respond_to do |format|
				format.js {
			      render :update do |page|
					    page.replace_html 'outcome_data_fields_table', :partial => 'outcome_columns/table', :locals => {:custom_template_id => @outcome_column.template_id}
					    page['new_outcome_column'].reset
						page.replace_html 'outcome_column_validation_message', ""
			      end
			    }
			end
		 else
				problem_html = "<div class='error_message'>The following errors prevented the column from being saved:<br/><ul>"
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
