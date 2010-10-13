class AdverseEventsController < ApplicationController
  # GET /adverse_events
  # GET /adverse_events.xml
  def index
    @adverse_events = AdverseEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adverse_events }
    end
  end

  # GET /adverse_events/1
  # GET /adverse_events/1.xml
  def show
    @adverse_event = AdverseEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adverse_event }
    end
  end

  # GET /adverse_events/new
  # GET /adverse_events/new.xml
  def new
    @adverse_event = AdverseEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adverse_event }
    end
  end

  # GET /adverse_events/1/edit
  def edit
    @adverse_event = AdverseEvent.find(params[:id])
  end

  # POST /adverse_events
  # POST /adverse_events.xml
  def create
    @adverse_event = AdverseEvent.new(params[:adverse_event])

    respond_to do |format|
      if @adverse_event.save
        format.html { redirect_to(@adverse_event, :notice => 'Adverse event was successfully created.') }
        format.xml  { render :xml => @adverse_event, :status => :created, :location => @adverse_event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adverse_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adverse_events/1
  # PUT /adverse_events/1.xml
  def update
    @adverse_event = AdverseEvent.find(params[:id])

    respond_to do |format|
      if @adverse_event.update_attributes(params[:adverse_event])
        format.html { redirect_to(@adverse_event, :notice => 'Adverse event was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adverse_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adverse_events/1
  # DELETE /adverse_events/1.xml
  def destroy
    @adverse_event = AdverseEvent.find(params[:id])
    @adverse_event.destroy

    respond_to do |format|
      format.html { redirect_to(adverse_events_url) }
      format.xml  { head :ok }
    end
  end
end
