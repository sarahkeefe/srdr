class OutcomeColumnValuesController < ApplicationController

  def new
    @outcome_column_value = OutcomeColumnValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_column_value }
    end
  end

  def edit
    @outcome_column_value = OutcomeColumnValue.find(params[:id])
  end

  # POST /outcome_column_values
  # POST /outcome_column_values.xml
  def create
    @outcome_column_value = OutcomeColumnValue.new(params[:outcome_column_value])

    respond_to do |format|
      if @outcome_column_value.save
        format.html { redirect_to(@outcome_column_value, :notice => 'Outcome column value was successfully created.') }
        format.xml  { render :xml => @outcome_column_value, :status => :created, :location => @outcome_column_value }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_column_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_column_values/1
  # PUT /outcome_column_values/1.xml
  def update
    @outcome_column_value = OutcomeColumnValue.find(params[:id])

    respond_to do |format|
      if @outcome_column_value.update_attributes(params[:outcome_column_value])
        format.html { redirect_to(@outcome_column_value, :notice => 'Outcome column value was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_column_value.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_column_values/1
  # DELETE /outcome_column_values/1.xml
  def destroy
    @outcome_column_value = OutcomeColumnValue.find(params[:id])
    @outcome_column_value.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_column_values_url) }
      format.xml  { head :ok }
    end
  end
end
