class OutcomeTimepointsController < ApplicationController
  # GET /outcome_timepoints/new
  # GET /outcome_timepoints/new.xml
  def new
    @outcome_timepoint = OutcomeTimepoint.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_timepoint }
    end
  end

  # GET /outcome_timepoints/1/edit
  def edit
    @outcome_timepoint = OutcomeTimepoint.find(params[:id])
  end

  # POST /outcome_timepoints
  # POST /outcome_timepoints.xml
  def create
    @outcome_timepoint = OutcomeTimepoint.new(params[:outcome_timepoint])

    respond_to do |format|
      if @outcome_timepoint.save
        format.html { redirect_to(@outcome_timepoint, :notice => 'Outcome timepoint was successfully created.') }
        format.xml  { render :xml => @outcome_timepoint, :status => :created, :location => @outcome_timepoint }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_timepoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_timepoints/1
  # PUT /outcome_timepoints/1.xml
  def update
    @outcome_timepoint = OutcomeTimepoint.find(params[:id])

    respond_to do |format|
      if @outcome_timepoint.update_attributes(params[:outcome_timepoint])
        format.html { redirect_to(@outcome_timepoint, :notice => 'Outcome timepoint was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_timepoint.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_timepoints/1
  # DELETE /outcome_timepoints/1.xml
  def destroy
    @outcome_timepoint = OutcomeTimepoint.find(params[:id])
    @outcome_timepoint.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_timepoints_url) }
      format.xml  { head :ok }
    end
  end
end
