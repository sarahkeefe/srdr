class QualityAspectsController < ApplicationController
  # GET /quality_aspects
  # GET /quality_aspects.xml
  def index
    @quality_aspects = QualityAspect.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quality_aspects }
    end
  end

  # GET /quality_aspects/1
  # GET /quality_aspects/1.xml
  def show
    @quality_aspect = QualityAspect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quality_aspect }
    end
  end

  # GET /quality_aspects/new
  # GET /quality_aspects/new.xml
  def new
    @quality_aspect = QualityAspect.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quality_aspect }
    end
  end

  # GET /quality_aspects/1/edit
  def edit
    @quality_aspect = QualityAspect.find(params[:id])
  end

  # POST /quality_aspects
  # POST /quality_aspects.xml
  def create
    @quality_aspect = QualityAspect.new(params[:quality_aspect])

    respond_to do |format|
      if @quality_aspect.save
        format.html { redirect_to(@quality_aspect, :notice => 'Quality aspect was successfully created.') }
        format.xml  { render :xml => @quality_aspect, :status => :created, :location => @quality_aspect }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quality_aspect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quality_aspects/1
  # PUT /quality_aspects/1.xml
  def update
    @quality_aspect = QualityAspect.find(params[:id])

    respond_to do |format|
      if @quality_aspect.update_attributes(params[:quality_aspect])
        format.html { redirect_to(@quality_aspect, :notice => 'Quality aspect was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quality_aspect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quality_aspects/1
  # DELETE /quality_aspects/1.xml
  def destroy
    @quality_aspect = QualityAspect.find(params[:id])
    @quality_aspect.destroy

    respond_to do |format|
      format.html { redirect_to(quality_aspects_url) }
      format.xml  { head :ok }
    end
  end
end
