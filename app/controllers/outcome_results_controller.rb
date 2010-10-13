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
