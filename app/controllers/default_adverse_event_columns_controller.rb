class DefaultAdverseEventColumnsController < ApplicationController
  # GET /default_adverse_event_columns
  # GET /default_adverse_event_columns.xml
  def index
    @default_adverse_event_columns = DefaultAdverseEventColumn.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @default_adverse_event_columns }
    end
  end

  # GET /default_adverse_event_columns/1
  # GET /default_adverse_event_columns/1.xml
  def show
    @default_adverse_event_column = DefaultAdverseEventColumn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @default_adverse_event_column }
    end
  end

  # GET /default_adverse_event_columns/new
  # GET /default_adverse_event_columns/new.xml
  def new
    @default_adverse_event_column = DefaultAdverseEventColumn.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @default_adverse_event_column }
    end
  end

  # GET /default_adverse_event_columns/1/edit
  def edit
    @default_adverse_event_column = DefaultAdverseEventColumn.find(params[:id])
  end

  # POST /default_adverse_event_columns
  # POST /default_adverse_event_columns.xml
  def create
    @default_adverse_event_column = DefaultAdverseEventColumn.new(params[:default_adverse_event_column])

    respond_to do |format|
      if @default_adverse_event_column.save
        format.html { redirect_to(@default_adverse_event_column, :notice => 'Default adverse event column was successfully created.') }
        format.xml  { render :xml => @default_adverse_event_column, :status => :created, :location => @default_adverse_event_column }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @default_adverse_event_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /default_adverse_event_columns/1
  # PUT /default_adverse_event_columns/1.xml
  def update
    @default_adverse_event_column = DefaultAdverseEventColumn.find(params[:id])

    respond_to do |format|
      if @default_adverse_event_column.update_attributes(params[:default_adverse_event_column])
        format.html { redirect_to(@default_adverse_event_column, :notice => 'Default adverse event column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @default_adverse_event_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /default_adverse_event_columns/1
  # DELETE /default_adverse_event_columns/1.xml
  def destroy
    @default_adverse_event_column = DefaultAdverseEventColumn.find(params[:id])
    @default_adverse_event_column.destroy

    respond_to do |format|
      format.html { redirect_to(default_adverse_event_columns_url) }
      format.xml  { head :ok }
    end
  end
end
