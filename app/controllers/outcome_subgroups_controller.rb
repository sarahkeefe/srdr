class OutcomeSubgroupsController < ApplicationController
  before_filter :require_user
  # GET /outcome_subgroups/new
  # GET /outcome_subgroups/new.xml
  def new
    @outcome_subgroup = OutcomeSubgroup.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_subgroup }
    end
  end

  # GET /outcome_subgroups/1/edit
  def edit
    @outcome_subgroup = OutcomeSubgroup.find(params[:id])
  end

  # POST /outcome_subgroups
  # POST /outcome_subgroups.xml
  def create
    @outcome_subgroup = OutcomeSubgroup.new(params[:outcome_subgroup])

    respond_to do |format|
      if @outcome_subgroup.save
        format.html { redirect_to(@outcome_subgroup, :notice => 'Outcome subgroup was successfully created.') }
        format.xml  { render :xml => @outcome_subgroup, :status => :created, :location => @outcome_subgroup }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_subgroup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_subgroups/1
  # PUT /outcome_subgroups/1.xml
  def update
    @outcome_subgroup = OutcomeSubgroup.find(params[:id])

    respond_to do |format|
      if @outcome_subgroup.update_attributes(params[:outcome_subgroup])
        format.html { redirect_to(@outcome_subgroup, :notice => 'Outcome subgroup was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_subgroup.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_subgroups/1
  # DELETE /outcome_subgroups/1.xml
  def destroy
    @outcome_subgroup = OutcomeSubgroup.find(params[:id])
    @outcome_subgroup.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_subgroups_url) }
      format.xml  { head :ok }
    end
  end
end
