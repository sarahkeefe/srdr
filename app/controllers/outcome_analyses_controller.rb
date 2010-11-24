class OutcomeAnalysesController < ApplicationController
  # GET /outcome_analyses
  # GET /outcome_analyses.xml
  def index
    @outcome_analyses = OutcomeAnalysis.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_analyses }
    end
  end

  # GET /outcome_analyses/1
  # GET /outcome_analyses/1.xml
  def show
    @outcome_analysis = OutcomeAnalysis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_analysis }
    end
  end

  # GET /outcome_analyses/new
  # GET /outcome_analyses/new.xml
  def new
    @outcome_analysis = OutcomeAnalysis.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_analysis }
    end
  end

  # GET /outcome_analyses/1/edit
  def edit
    @outcome_analysis = OutcomeAnalysis.find(params[:id])
  end

  # POST /outcome_analyses
  # POST /outcome_analyses.xml
  def create
    analyses = get_analysis_params(params) 
    outcome_id = params[:outcome_analysis][:outcome_id]
    subgroup_id = params[:outcome_analysis][:subgroup_id]
    timepoint_id = params[:outcome_analysis][:timepoint_id]
    OutcomeAnalysis.remove_analyses(session[:study_id])
    @outcome_analysis = ""
    analyses.each do |oa|
    	@outcome_analysis = OutcomeAnalysis.new(params[oa])
    	@outcome_analysis.outcome_id = outcome_id.to_i
    	@outcome_analysis.subgroup_id = subgroup_id.to_i
    	@outcome_analysis.timepoint_id = timepoint_id.to_i
    	@outcome_analysis.categorical_or_continuous = cat_or_cont
    	@outcome_analysis.estimation_parameter_type = params[:outcome_analysis][:estimation_parameter_type]
    	@outcome_analysis.parameter_dispersion_type = params[:outcome_analysis][:parameter_dispersion_type]
    	@outcome_analysis.adjusted_estimation_parameter_type = params[:outcome_analysis][:adjusted_estimation_parameter_type]
    	@outcome_analysis.adjusted_parameter_dispersion_type = params[:outcome_analysis][:adjusted_parameter_dispersion_type]
    	@outcome_analysis.study_id = session[:study_id]
    	@outcome_analysis.save
    end
  	

    respond_to do |format|
      if @outcome_analysis.save      	
      	format.html { redirect_to(@outcome_analysis, :notice => 'Outcome analysis was successfully created.') }
        format.xml  { render :xml => @outcome_analysis, :status => :created, :location => @outcome_analyasis }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_analysis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_analyses/1
  # PUT /outcome_analyses/1.xml
  def update
    @outcome_analyasis = OutcomeAnalysis.find(params[:id])

    respond_to do |format|
      if @outcome_analyasis.update_attributes(params[:outcome_analysis])
        format.html { redirect_to(@outcome_analyasis, :notice => 'Outcome analysis was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_analyasis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_analyses/1
  # DELETE /outcome_analyses/1.xml
  def destroy
    @outcome_analysis = OutcomeAnalysis.find(params[:id])
    @outcome_analysis.destroy

    respond_to do |format|
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
