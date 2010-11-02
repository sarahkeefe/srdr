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
	oid = params[:outcome_id].to_i
	@study_timepoints = Outcome.get_timepoints_array(oid)

	for a in @study_arms
		OutcomeResult.save_general_results(session[:study_id], a, oid, params)
	end
	
	for a in @study_arms
		for p in @study_timepoints
			OutcomeResult.save_timepoint_results(oid, session[:study_id], a, p, params)
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
end
