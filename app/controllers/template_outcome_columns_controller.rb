class TemplateOutcomeColumnsController < ApplicationController
  # GET /template_outcome_columns
  # GET /template_outcome_columns.xml
  def index
    @template_outcome_columns = TemplateOutcomeColumn.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @template_outcome_columns }
    end
  end

  # GET /template_outcome_columns/1
  # GET /template_outcome_columns/1.xml
  def show
    @template_outcome_column = TemplateOutcomeColumn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @template_outcome_column }
    end
  end

  # GET /template_outcome_columns/new
  # GET /template_outcome_columns/new.xml
  def new
    @template_outcome_column = TemplateOutcomeColumn.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @template_outcome_column }
    end
  end

  # GET /template_outcome_columns/1/edit
  def edit
    @template_outcome_column = TemplateOutcomeColumn.find(params[:id])
  end

  # POST /template_outcome_columns
  # POST /template_outcome_columns.xml
  def create
    @template_outcome_column = TemplateOutcomeColumn.new(params[:template_outcome_column])

    respond_to do |format|
      if @template_outcome_column.save
        format.html { redirect_to(@template_outcome_column, :notice => 'Template outcome column was successfully created.') }
        format.xml  { render :xml => @template_outcome_column, :status => :created, :location => @template_outcome_column }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @template_outcome_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /template_outcome_columns/1
  # PUT /template_outcome_columns/1.xml
  def update
    @template_outcome_column = TemplateOutcomeColumn.find(params[:id])

    respond_to do |format|
      if @template_outcome_column.update_attributes(params[:template_outcome_column])
        format.html { redirect_to(@template_outcome_column, :notice => 'Template outcome column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @template_outcome_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /template_outcome_columns/1
  # DELETE /template_outcome_columns/1.xml
  def destroy
    @template_outcome_column = TemplateOutcomeColumn.find(params[:id])
    @template_outcome_column.destroy

    respond_to do |format|
      format.html { redirect_to(template_outcome_columns_url) }
      format.xml  { head :ok }
    end
  end
end
