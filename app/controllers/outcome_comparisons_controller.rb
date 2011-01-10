class OutcomeComparisonsController < ApplicationController
  # GET /outcome_comparisons/new
  # GET /outcome_comparisons/new.xml
  def new
    @outcome_comparison = OutcomeComparison.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_comparison }
    end
  end

  # GET /outcome_comparisons/1/edit
  def edit
    @outcome_comparison = OutcomeComparison.find(params[:id])
  end

  # POST /outcome_comparisons
  # POST /outcome_comparisons.xml
  def create
    OutcomeComparison.save_data_points(params, session[:study_id])

    respond_to do |format|
			format.js{
				render :update do |page|
				# do something here to show that it is saved correctly
				#	page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
				end
			}
		end	
  end

  # PUT /outcome_comparisons/1
  # PUT /outcome_comparisons/1.xml
  def update
    OutcomeComparison.save_data_points(params, session[:study_id])

	  respond_to do |format|
	
			format.js{
				render :update do |page|
					# do something here to show that it is saved correctly
					#page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
				end
			}
		end
  end

  # DELETE /outcome_comparisons/1
  # DELETE /outcome_comparisons/1.xml
  def destroy
    @outcome_comparison = OutcomeComparison.find(params[:id])
    @outcome_comparison.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_comparisons_url) }
      format.xml  { head :ok }
    end
  end
  
  def clear_table
	OutcomeComparison.clear_table(params)

	@study = Study.find(params[:study_id])
	@study_arms = Arm.where(:study_id => params[:study_id]).all
  	template_id = Study.get_template_id(@study.id)
	@categorical_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Categorical").all
	@continuous_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Continuous").all
	@template_categorical_columns = OutcomeComparisonColumn.where(:template_id => template_id, :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeComparisonColumn.where(:template_id => template_id, :outcome_type => "Continuous").all
	@outcome_comparisons = OutcomeComparison.new

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
  
end
