class OutcomeSubgroupLevelsController < ApplicationController
  # GET /outcome_subgroup_levels
  # GET /outcome_subgroup_levels.xml
  def index
    @outcome_subgroup_levels = OutcomeSubgroupLevel.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_subgroup_levels }
    end
  end

  # GET /outcome_subgroup_levels/1
  # GET /outcome_subgroup_levels/1.xml
  def show
    @outcome_subgroup_level = OutcomeSubgroupLevel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_subgroup_level }
    end
  end

  # GET /outcome_subgroup_levels/new
  # GET /outcome_subgroup_levels/new.xml
  def new
    @outcome_subgroup_level = OutcomeSubgroupLevel.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_subgroup_level }
    end
  end

  # GET /outcome_subgroup_levels/1/edit
  def edit
    @outcome_subgroup_level = OutcomeSubgroupLevel.find(params[:id])
  end

  # POST /outcome_subgroup_levels
  # POST /outcome_subgroup_levels.xml
  def create
    @outcome_subgroup_level = OutcomeSubgroupLevel.new(params[:outcome_subgroup_level])

    respond_to do |format|
      if @outcome_subgroup_level.save
        format.html { redirect_to(@outcome_subgroup_level, :notice => 'Outcome subgroup level was successfully created.') }
        format.xml  { render :xml => @outcome_subgroup_level, :status => :created, :location => @outcome_subgroup_level }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_subgroup_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_subgroup_levels/1
  # PUT /outcome_subgroup_levels/1.xml
  def update
    @outcome_subgroup_level = OutcomeSubgroupLevel.find(params[:id])

    respond_to do |format|
      if @outcome_subgroup_level.update_attributes(params[:outcome_subgroup_level])
        format.html { redirect_to(@outcome_subgroup_level, :notice => 'Outcome subgroup level was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_subgroup_level.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_subgroup_levels/1
  # DELETE /outcome_subgroup_levels/1.xml
  def destroy
    @outcome_subgroup_level = OutcomeSubgroupLevel.find(params[:id])
    @outcome_subgroup_level.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_subgroup_levels_url) }
      format.xml  { head :ok }
    end
  end
end
