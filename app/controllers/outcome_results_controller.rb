class OutcomeResultsController < ApplicationController
  def new
    @outcome_result = OutcomeResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_result }
    end
  end

  def edit
    @outcome_result = OutcomeResult.find(params[:id])
  end 
 
  # POST /outcome_results 
  # POST /outcome_results.xml
  def create
    @outcome_result = OutcomeResult.new(params[:outcome_result])
	@study_arms = Arm.where(:study_id => session[:study_id]).all
	
	outcome_id = params[:outcome_id].to_i
	@selected_timepoint = params[:selected_timepoint].to_i
	@selected_subgroup = params[:selected_subgroup].to_i
	@selected_outcome_object = Outcome.find(outcome_id)	
	
	@outcome_columns = OutcomeColumn.where(:outcome_id => outcome_id, :timepoint_id => @selected_timepoint, :subgroup_id => @selected_subgroup).all

	for a in @study_arms
		OutcomeResult.save_general_results(session[:study_id], a, outcome_id, @selected_timepoint, @selected_subgroup, params)
		for i in @outcome_columns
			OutcomeResult.save_custom_results(session[:study_id], a, outcome_id, @selected_timepoint, @selected_subgroup, i.id, params)
		end
	end

    respond_to do |format|

	render :update do |page|
		format.js{
	page.call "alert('hi')"
page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
		}
		end
	end
	
  end

  # PUT /outcome_results/1
  # PUT /outcome_results/1.xml
  def update
    @outcome_result = OutcomeResult.find(params[:id])
	@study_arms = Arm.where(:study_id => session[:study_id]).all
	
	outcome_id = params[:outcome_id].to_i
	@selected_timepoint = params[:selected_timepoint].to_i
	@selected_subgroup = params[:selected_subgroup].to_i
	
	@outcome_columns = OutcomeColumn.where(:outcome_id => outcome_id, :timepoint_id => @selected_timepoint, :subgroup_id => @selected_subgroup).all
	@selected_outcome_object = Outcome.find(outcome_id)
	
	for a in @study_arms
		OutcomeResult.save_general_results(session[:study_id], a, outcome_id, @selected_timepoint, @selected_subgroup, params)
		for i in @outcome_columns
			OutcomeResult.save_custom_results(session[:study_id], a, outcome_id, @selected_timepoint, @selected_subgroup, i.id, params)
		end
	end

    respond_to do |format|
	render :update do |page|
		format.js{
	page.call "alert('hi2')"
	page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'

		}
		end
	end
	
  end

  # DELETE /outcome_results/1
  # DELETE /outcome_results/1.xml
  def destroy
    @outcome_result = OutcomeResult.find(params[:id])
    @outcome_result.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_results_url) }
      format.xml  { head :ok }
    end
  end
  
  def clear_table
	OutcomeResult.clear_table(params)
  
	# this is all information needed to show the table properly
	@selected_outcome_object = Outcome.find(params[:outcome_id])
	@selected_subgroup = params[:subgroup_id]
	@selected_timepoint = params[:timepoint_id]
	@selected_outcome_object_results =OutcomeResult.get_selected_outcome_results(params[:outcome_id], params[:subgroup_id], params[:timepoint_id])
	@study_arms = Arm.where(:study_id => session[:study_id]).all
	
    respond_to do |format|
        	selected_outcome_object = @selected_outcome_object
		format.js {
	
				render :update do |page|
					page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
					page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
					page.call "Custom.init"
		  		end
				}
		end
 end
 
 def delete_column
	@column = OutcomeColumn.where(:id => params[:id]).first
	@column.destroy
	
	OutcomeColumnValue.where(:column_id => params[:id]).all.each{|i| i.destroy}
	@selected_outcome_object = Outcome.find(params[:outcome_id])
	@selected_subgroup = params[:subgroup_id]
	@selected_timepoint = params[:timepoint_id]
	@selected_outcome_object_results =OutcomeResult.get_selected_outcome_results(params[:outcome_id], params[:subgroup_id], params[:timepoint_id])
	@study_arms = Arm.where(:study_id => session[:study_id]).all
	
     respond_to do |format|
	selected_outcome_object = @selected_outcome_object	
	format.js {
		      render :update do |page|
					page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
					page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
		  		end
				}
		end
 end
 
end
