class OutcomeComparisonsController < ApplicationController
  # GET /outcome_comparisons
  # GET /outcome_comparisons.xml
  def index
    @outcome_comparisons = OutcomeComparison.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_comparisons }
    end
  end

  # GET /outcome_comparisons/1
  # GET /outcome_comparisons/1.xml
  def show
    @outcome_comparison = OutcomeComparison.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_comparison }
    end
  end

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
    @outcome_comparison = OutcomeComparison.new(params[:outcome_comparison])

    respond_to do |format|
      if @outcome_comparison.save
        format.html { redirect_to(@outcome_comparison, :notice => 'Outcome comparison was successfully created.') }
        format.xml  { render :xml => @outcome_comparison, :status => :created, :location => @outcome_comparison }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_comparison.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_comparisons/1
  # PUT /outcome_comparisons/1.xml
  def update
    @outcome_comparison = OutcomeComparison.find(params[:id])

    respond_to do |format|
      if @outcome_comparison.update_attributes(params[:outcome_comparison])
        format.html { redirect_to(@outcome_comparison, :notice => 'Outcome comparison was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_comparison.errors, :status => :unprocessable_entity }
      end
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
end
