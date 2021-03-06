class OutcomeAnalysesController < ApplicationController
  before_filter :require_user
  # GET /outcome_analyses/new
  # GET /outcome_analyses/new.xml
  def new
    @outcome_analysis = OutcomeAnalysis.new
    @model_name = "outcome_analysis"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_analysis }
    end
  end

  def update_selections
  	
  end
  
  # Update the first comparison partial based on the selected analysis type
  def update_for_analysis_type
  	@selected_analysis = params[:selected_analysis]
  	
  	respond_to do |format|
      format.js { 
      	render :update do |page|
      		partial_used = case @selected_analysis
    				when "Log Rank" then "log_rank"
    				when "t-Test, 1-sided" then "choice_of_grouping"
    				when "t-Test, 2-sided" then "two_sided_t"
    				else "default"
    			end
      	  page.replace_html "comparison_level1", :partial=>"outcome_analyses/partials/analyses/"+partial_used.to_s
      	end
      }
    end
  end
  
  # Based on the selection of how the comparison groups are being formed, provide
  # grouping options.
  def update_group_selector
  	@grouped_by = params[:selected_grouping]
  	render :update do |page|
  		partial_used = case @grouped_by
			when "Arms" then "group_by_arm_options"
			when "Groups" then "group_by_category_options"
			when "Timepoints" then "group_by_timepoint_options"
		  end
		end
  end
  
  # GET /outcome_analyses/1/edit
  def edit
    @outcome_analysis = OutcomeAnalysis.find(params[:id])
  end

  # POST /outcome_analyses
  # POST /outcome_analyses.xml
  def create
  begin
    analyses = get_analysis_params(params) 
    outcome_id = params[:selected_outcome]
    subgroup_id = params[:selected_subgroup]
    timepoint_id = params[:selected_timepoint]
    OutcomeAnalysis.remove_analyses(session[:study_id], outcome_id, subgroup_id.to_s, timepoint_id.to_s)
    @outcome_analysis = ""
    analyses.each do |oa|
    	@outcome_analysis = OutcomeAnalysis.new(params[oa])
    	@outcome_analysis.outcome_id = outcome_id.to_i
    	@outcome_analysis.subgroup_comp = subgroup_id
    	@outcome_analysis.timepoint_comp = timepoint_id
    	@outcome_analysis.estimation_parameter_type = params[:outcome_analysis][:estimation_parameter_type]
    	@outcome_analysis.parameter_dispersion_type = params[:outcome_analysis][:parameter_dispersion_type]
    	@outcome_analysis.adjusted_estimation_parameter_type = params[:outcome_analysis][:adjusted_estimation_parameter_type]
    	@outcome_analysis.adjusted_parameter_dispersion_type = params[:outcome_analysis][:adjusted_parameter_dispersion_type]
    	@outcome_analysis.study_id = session[:study_id]
  		@outcome_analysis.save
    end
  rescue Exception=>e
    		print "\n\n\n\nWe may have a problem with the study analysis\n\n\n\n"
  end
  
    respond_to do |format|
      if @outcome_analysis.save      	
      	@saved_analyses = OutcomeAnalysis.get_saved_analyses(session[:study_id])
      	format.html { redirect_to(@outcome_analysis, :notice => 'Outcome analysis was successfully created.') }
        format.xml  { render :xml => @outcome_analysis, :status => :created, :location => @outcome_analysis }
        format.js{
        	render :update do |page|
        		 page.replace_html 'existing_analyses',:partial => 'outcome_analyses/saved_analyses'
        	end
      	}
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_analysis.errors, :status => :unprocessable_entity }
        format.js{
        	render :update do |page|
        		 page.replace_html 'existing_analyses',:partial => 'outcome_analyses/saved_analyses'
        	end
      	}
      end
    end
  end

  # PUT /outcome_analyses/1
  # PUT /outcome_analyses/1.xml
  def update
    @outcome_analysis = OutcomeAnalysis.find(params[:id])

    respond_to do |format|
      if @outcome_analysis.update_attributes(params[:outcome_analysis])
        format.html { redirect_to(@outcome_analysis, :notice => 'Outcome analysis was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_analysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_analyses/1
  # DELETE /outcome_analyses/1.xml
  def destroy
    @outcome_analysis = OutcomeAnalysis.find(params[:outcome_analysis_id])
    @outcome_analysis.destroy

		@saved_analyses = OutcomeAnalysis.get_saved_analyses(session[:study_id])
    respond_to do |format|
    	format.js{ 
    	  render :update do |page|
    	  	page.replace_html 'existing_analyses',:partial => 'outcome_analyses/saved_analyses'
    	  end
  		}
      format.html { redirect_to(outcome_analyses_url) }
      format.xml  { head :ok }
    end
  end
  
  def get_analysis_params(form_params)
  	analyses = Array.new
  	form_params.keys.each do |key|
  		if key =~ /^outcome_analysis_/
  			analyses.push(key)
  		end
  	end
  	return analyses
  end
end
