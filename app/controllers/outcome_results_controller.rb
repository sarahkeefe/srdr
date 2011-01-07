class OutcomeResultsController < ApplicationController
  before_filter :require_user
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
    OutcomeResult.save_data_points(params, session[:study_id])
	
	# save any footnotes associated with the data
	footnotes = get_footnotes_from_params(params)
	
    # move this to model?	
	unless footnotes.empty?
    	Footnote.remove_entries(session[:study_id],params[:selected_outcome],params[:selected_subgroup],params[:selected_timepoint])
    	FootnoteField.remove_entries(session[:study_id],params[:selected_outcome],params[:selected_subgroup],params[:selected_timepoint])
    	footnotes.each do |fnote|
    		mynote = Footnote.new(fnote)
    		mynote.save
    	end
	  end    

    respond_to do |format|
			format.js{
				render :update do |page|
				#	page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
				end
			}
		end	
  end

  # PUT /outcome_results/1
  # PUT /outcome_results/1.xml
  def update
    OutcomeResult.save_data_points(params, session[:study_id])
	# save any footnotes associated with the data
    footnotes = get_footnotes_from_params(params) # ( in the application controller )
	
	# move this to model?
    unless footnotes.empty?
    	Footnote.remove_entries(session[:study_id],params[:selected_outcome],params[:selected_subgroup],params[:selected_timepoint])
    	FootnoteField.remove_entries(session[:study_id],params[:selected_outcome],params[:selected_subgroup],params[:selected_timepoint])
    	footnotes.each do |fnote|
    		mynote = Footnote.new(fnote)
    		mynote.save
    	end
	  else
	  	FootnoteField.remove_entries(session[:study_id],params[:selected_outcome],params[:selected_subgroup],params[:selected_timepoint])
	  end
	
	  respond_to do |format|
	
			format.js{
				render :update do |page|
					#page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
				end
			}
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

	@study = Study.find(params[:study_id])
	@study_arms = Arm.where(:study_id => params[:study_id]).all
  	template_id = Study.get_template_id(@study.id)
	@categorical_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Categorical").all
	@continuous_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Continuous").all
	@template_categorical_columns = OutcomeColumn.where(:template_id => template_id, :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeColumn.where(:template_id => template_id, :outcome_type => "Continuous").all
	@outcome_data_points = OutcomeResult.new

    respond_to do |format|
		format.js {
				render :update do |page|
					page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
					#page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
					#page.call "Custom.init"
		  		end
				}
		end
 end
 
 def delete_column
	@column = OutcomeColumn.where(:id => params[:id]).first
	@column.destroy
	
	# the following few lines are used by the footnote generations
	# gather any footnotes for the first selections
	@footnotes = Footnote.where(:study_id=>session[:study_id], :outcome_id=>@selected_outcome_object.id,
														  :subgroup_id=>@selected_subgroup, :timepoint_id=>@selected_timepoint)
		
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
