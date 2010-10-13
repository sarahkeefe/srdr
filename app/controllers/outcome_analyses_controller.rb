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
    @outcome_analyasis = OutcomeAnalysis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_analyasis }
    end
  end

  # GET /outcome_analyses/new
  # GET /outcome_analyses/new.xml
  def new
    @outcome_analyasis = OutcomeAnalysis.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_analyasis }
    end
  end

  # GET /outcome_analyses/1/edit
  def edit
    @outcome_analyasis = OutcomeAnalysis.find(params[:id])
  end

  # POST /outcome_analyses
  # POST /outcome_analyses.xml
  def create
    @outcome_analyasis = OutcomeAnalysis.new(params[:outcome_analyasis])

    respond_to do |format|
      if @outcome_analyasis.save
        format.html { redirect_to(@outcome_analyasis, :notice => 'Outcome analysis was successfully created.') }
        format.xml  { render :xml => @outcome_analyasis, :status => :created, :location => @outcome_analyasis }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_analyasis.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_analyses/1
  # PUT /outcome_analyses/1.xml
  def update
    @outcome_analyasis = OutcomeAnalysis.find(params[:id])

    respond_to do |format|
      if @outcome_analyasis.update_attributes(params[:outcome_analyasis])
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
    @outcome_analyasis = OutcomeAnalysis.find(params[:id])
    @outcome_analyasis.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_analyses_url) }
      format.xml  { head :ok }
    end
  end
end
