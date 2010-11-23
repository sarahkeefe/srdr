class OutcomeColumnsController < ApplicationController
  # GET /outcome_columns
  # GET /outcome_columns.xml
  def index
    @outcome_columns = OutcomeColumn.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_columns }
    end
  end

  # GET /outcome_columns/1
  # GET /outcome_columns/1.xml
  def show
    @outcome_column = OutcomeColumn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_column }
    end
  end

  # GET /outcome_columns/new
  # GET /outcome_columns/new.xml
  def new
    @outcome_column = OutcomeColumn.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_column }
    end
  end

  # GET /outcome_columns/1/edit
  def edit
    @outcome_column = OutcomeColumn.find(params[:id])
  end

  # POST /outcome_columns
  # POST /outcome_columns.xml
  def create
    @outcome_column = OutcomeColumn.new(params[:outcome_column])

    respond_to do |format|
      if @outcome_column.save
        format.html { redirect_to(@outcome_column, :notice => 'Outcome column was successfully created.') }
        format.xml  { render :xml => @outcome_column, :status => :created, :location => @outcome_column }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_columns/1
  # PUT /outcome_columns/1.xml
  def update
    @outcome_column = OutcomeColumn.find(params[:id])

    respond_to do |format|
      if @outcome_column.update_attributes(params[:outcome_column])
        format.html { redirect_to(@outcome_column, :notice => 'Outcome column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_columns/1
  # DELETE /outcome_columns/1.xml
  def destroy
    @outcome_column = OutcomeColumn.find(params[:id])
    @outcome_column.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_columns_url) }
      format.xml  { head :ok }
    end
  end
end
