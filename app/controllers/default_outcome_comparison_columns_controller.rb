class DefaultOutcomeComparisonColumnsController < ApplicationController
  # GET /default_outcome_comparison_columns
  # GET /default_outcome_comparison_columns.xml
  def index
    @default_outcome_comparison_columns = DefaultOutcomeComparisonColumn.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @default_outcome_comparison_columns }
    end
  end

  # GET /default_outcome_comparison_columns/1
  # GET /default_outcome_comparison_columns/1.xml
  def show
    @default_outcome_comparison_column = DefaultOutcomeComparisonColumn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @default_outcome_comparison_column }
    end
  end

  # GET /default_outcome_comparison_columns/new
  # GET /default_outcome_comparison_columns/new.xml
  def new
    @default_outcome_comparison_column = DefaultOutcomeComparisonColumn.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @default_outcome_comparison_column }
    end
  end

  # GET /default_outcome_comparison_columns/1/edit
  def edit
    @default_outcome_comparison_column = DefaultOutcomeComparisonColumn.find(params[:id])
  end

  # POST /default_outcome_comparison_columns
  # POST /default_outcome_comparison_columns.xml
  def create
    @default_outcome_comparison_column = DefaultOutcomeComparisonColumn.new(params[:default_outcome_comparison_column])

    respond_to do |format|
      if @default_outcome_comparison_column.save
        format.html { redirect_to(@default_outcome_comparison_column, :notice => 'Default outcome comparison column was successfully created.') }
        format.xml  { render :xml => @default_outcome_comparison_column, :status => :created, :location => @default_outcome_comparison_column }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @default_outcome_comparison_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /default_outcome_comparison_columns/1
  # PUT /default_outcome_comparison_columns/1.xml
  def update
    @default_outcome_comparison_column = DefaultOutcomeComparisonColumn.find(params[:id])

    respond_to do |format|
      if @default_outcome_comparison_column.update_attributes(params[:default_outcome_comparison_column])
        format.html { redirect_to(@default_outcome_comparison_column, :notice => 'Default outcome comparison column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @default_outcome_comparison_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /default_outcome_comparison_columns/1
  # DELETE /default_outcome_comparison_columns/1.xml
  def destroy
    @default_outcome_comparison_column = DefaultOutcomeComparisonColumn.find(params[:id])
    @default_outcome_comparison_column.destroy

    respond_to do |format|
      format.html { redirect_to(default_outcome_comparison_columns_url) }
      format.xml  { head :ok }
    end
  end
end
