class OutcomeTimepointResultsController < ApplicationController
  # GET /outcome_timepoint_results
  # GET /outcome_timepoint_results.xml
  def index
    @outcome_timepoint_results = OutcomeTimepointResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_timepoint_results }
    end
  end

  # GET /outcome_timepoint_results/1
  # GET /outcome_timepoint_results/1.xml
  def show
    @outcome_timepoint_result = OutcomeTimepointResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_timepoint_result }
    end
  end

  # GET /outcome_timepoint_results/new
  # GET /outcome_timepoint_results/new.xml
  def new
    @outcome_timepoint_result = OutcomeTimepointResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_timepoint_result }
    end
  end

  # GET /outcome_timepoint_results/1/edit
  def edit
    @outcome_timepoint_result = OutcomeTimepointResult.find(params[:id])
  end

  # POST /outcome_timepoint_results
  # POST /outcome_timepoint_results.xml
  def create
    @outcome_timepoint_result = OutcomeTimepointResult.new(params[:outcome_timepoint_result])

    respond_to do |format|
      if @outcome_timepoint_result.save
        format.html { redirect_to(@outcome_timepoint_result, :notice => 'Outcome timepoint result was successfully created.') }
        format.xml  { render :xml => @outcome_timepoint_result, :status => :created, :location => @outcome_timepoint_result }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_timepoint_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_timepoint_results/1
  # PUT /outcome_timepoint_results/1.xml
  def update
    @outcome_timepoint_result = OutcomeTimepointResult.find(params[:id])

    respond_to do |format|
      if @outcome_timepoint_result.update_attributes(params[:outcome_timepoint_result])
        format.html { redirect_to(@outcome_timepoint_result, :notice => 'Outcome timepoint result was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_timepoint_result.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_timepoint_results/1
  # DELETE /outcome_timepoint_results/1.xml
  def destroy
    @outcome_timepoint_result = OutcomeTimepointResult.find(params[:id])
    @outcome_timepoint_result.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_timepoint_results_url) }
      format.xml  { head :ok }
    end
  end
end
