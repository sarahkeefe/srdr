class OutcomeResultsController < ApplicationController
  # GET /outcome_results
  # GET /outcome_results.xml
  def index
    @outcome_results = OutcomeResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_results }
    end
  end

  # GET /outcome_results/1
  # GET /outcome_results/1.xml
  def show
    @outcome_result = OutcomeResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_result }
    end
  end

  # GET /outcome_results/new
  # GET /outcome_results/new.xml
  def new
    @outcome_result = OutcomeResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_result }
    end
  end

  # GET /outcome_results/1/edit
  def edit
    @outcome_result = OutcomeResult.find(params[:id])
  end

  # POST /outcome_results 
  # POST /outcome_results.xml
  def create
    @outcome_result = OutcomeResult.new(params[:outcome_result])
	@study_arms = Study.get_arms(session[:study_id].to_i)
	#print "PARAMMMMMMS" + params[:outcome_id]
	#print "AAAAAAAAARMS" + @study_arms.to_s
	oid = params[:outcome_id].to_i
	@study_timepoints = Outcome.get_timepoints_array(oid)

	for a in @study_arms
		for p in @study_timepoints
			#if !params["arm" + a.id.to_s + "nanalyzed"][p.id.to_s] == "" || !params["measure_type"]["measure_type"] == "" || !params["arm" + a.id.to_s + "measurereg"][p.id.to_s] == "" || !params["measure_disp_type"]["measure_type"] == "" || !params["arm" + a.id.to_s + "measuredisp"][p.id.to_s] == "" || !params["arm" + a.id.to_s + "pvalue"][p.id.to_s] == ""
				@existing = OutcomeResult.where(:study_id => session[:study_id], :arm_id => a.id, :timepoint_id => p.id).all
				if @existing.length > 0
					for i in @existing
						OutcomeResult.compare_and_update_result_nanalyzed(i, params["arm" + a.id.to_s + "nanalyzed"][p.id.to_s])
						OutcomeResult.compare_and_update_result_measuretype(i, params["measure_type"]["measure_type"])		
						OutcomeResult.compare_and_update_result_measurevalue(i, params["arm" + a.id.to_s + "measurereg"][p.id.to_s])
						OutcomeResult.compare_and_update_result_measuredisptype(i, params["measure_disp_type"]["measure_type"])						
						OutcomeResult.compare_and_update_result_measuredispvalue(i, params["arm" + a.id.to_s + "measuredisp"][p.id.to_s])
						OutcomeResult.compare_and_update_result_pvalue(i, params["arm" + a.id.to_s + "pvalue"][p.id.to_s])						
					end
				else
					@outcome_result_new = OutcomeResult.new(params[:outcome_result])
					@outcome_result_new.arm_id = a.id
					@outcome_result_new.timepoint_id = p.id
					@outcome_result_new.study_id = session[:study_id]			
					@outcome_result_new.n_analyzed = params["arm" + a.id.to_s + "nanalyzed"][p.id.to_s]
					@outcome_result_new.measure_type = params["measure_type"]["measure_type"]
					@outcome_result_new.measure_value = params["arm" + a.id.to_s + "measurereg"][p.id.to_s]
					@outcome_result_new.measure_dispersion_type = params["measure_disp_type"]["measure_type"]
					@outcome_result_new.measure_dispersion_value = params["arm" + a.id.to_s + "measuredisp"][p.id.to_s]
					@outcome_result_new.p_value =  params["arm" + a.id.to_s + "pvalue"][p.id.to_s]
					@outcome_result_new.save
				end
			#end
		end
	end
	
	
	
    respond_to do |format|
      if @outcome_result.save
        format.html { redirect_to(@outcome_result, :notice => 'Outcome result was successfully created.') }
        format.xml  { render :xml => @outcome_result, :status => :created, :location => @outcome_result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_result.errors, :status => :unprocessable_entity }
      end
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
end
