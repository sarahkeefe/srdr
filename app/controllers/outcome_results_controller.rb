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
	oid = params[:outcome_id].to_i
	tp_id = params[:selected_timepoint].to_i
	subgroup_id = params[:selected_subgroup].to_i
	@outcome_columns = OutcomeColumn.where(:outcome_id => oid, :timepoint_id => tp_id, :subgroup_id => subgroup_id).all
	
	for a in @study_arms
		OutcomeResult.save_general_results(session[:study_id], a, oid, tp_id, subgroup_id, params)
		print "MMMM HMMM "
		for i in @outcome_columns
			print "666 "
			OutcomeResult.save_custom_results(session[:study_id], a, oid, tp_id, subgroup_id, i.id, params)
		end
	end
	
    respond_to do |format|
        format.html { redirect_to(@outcome_result, :notice => 'Outcome result was successfully created.') }
        format.xml  { render :xml => @outcome_result, :status => :created, :location => @outcome_result }
    end
  end

  # PUT /outcome_results/1
  # PUT /outcome_results/1.xml
  def update
    @outcome_result = OutcomeResult.find(params[:id])

    respond_to do |format|
      if @outcome_result.update_attributes(params[:outcome_result])
        format.html { redirect_to(@outcome_result, :notice => 'Outcome result was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_result.errors, :status => :unprocessable_entity }
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
        format.js {
		      render :update do |page|
					page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
					page.call "Custom.init();"
		  		end
				}
		end
 end
end
