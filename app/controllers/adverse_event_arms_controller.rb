class AdverseEventArmsController < ApplicationController
  before_filter :require_user
  # GET /adverse_event_arms/new
  # GET /adverse_event_arms/new.xml
  def new
    @adverse_event_arm = AdverseEventArm.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adverse_event_arm }
    end
  end

  # GET /adverse_event_arms/1/edit
  def edit
    @adverse_event_arm = AdverseEventArm.find(params[:id])
  end

  # POST /adverse_event_arms
  # POST /adverse_event_arms.xml
  def create
    @adverse_event_arm = AdverseEventArm.new(params[:adverse_event_arm])

    respond_to do |format|
      if @adverse_event_arm.save
        format.html { redirect_to(@adverse_event_arm, :notice => 'Adverse event arm was successfully created.') }
        format.xml  { render :xml => @adverse_event_arm, :status => :created, :location => @adverse_event_arm }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adverse_event_arm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adverse_event_arms/1
  # PUT /adverse_event_arms/1.xml
  def update
    @adverse_event_arm = AdverseEventArm.find(params[:id])

    respond_to do |format|
      if @adverse_event_arm.update_attributes(params[:adverse_event_arm])
        format.html { redirect_to(@adverse_event_arm, :notice => 'Adverse event arm was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adverse_event_arm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adverse_event_arms/1
  # DELETE /adverse_event_arms/1.xml
  def destroy
    @adverse_event_arm = AdverseEventArm.find(params[:id])
    @adverse_event_arm.destroy

    respond_to do |format|
      format.html { redirect_to(adverse_event_arms_url) }
      format.xml  { head :ok }
    end
  end
end
