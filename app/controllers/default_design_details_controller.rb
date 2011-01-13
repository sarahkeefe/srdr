class DefaultDesignDetailsController < ApplicationController
  # GET /default_design_details
  # GET /default_design_details.xml
  def index
    @default_design_details = DefaultDesignDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @default_design_details }
    end
  end

  # GET /default_design_details/1
  # GET /default_design_details/1.xml
  def show
    @default_design_detail = DefaultDesignDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @default_design_detail }
    end
  end

  # GET /default_design_details/new
  # GET /default_design_details/new.xml
  def new
    @default_design_detail = DefaultDesignDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @default_design_detail }
    end
  end

  # GET /default_design_details/1/edit
  def edit
    @default_design_detail = DefaultDesignDetail.find(params[:id])
  end

  # POST /default_design_details
  # POST /default_design_details.xml
  def create
    @default_design_detail = DefaultDesignDetail.new(params[:default_design_detail])

    respond_to do |format|
      if @default_design_detail.save
        format.html { redirect_to(@default_design_detail, :notice => 'Default design detail was successfully created.') }
        format.xml  { render :xml => @default_design_detail, :status => :created, :location => @default_design_detail }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @default_design_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /default_design_details/1
  # PUT /default_design_details/1.xml
  def update
    @default_design_detail = DefaultDesignDetail.find(params[:id])

    respond_to do |format|
      if @default_design_detail.update_attributes(params[:default_design_detail])
        format.html { redirect_to(@default_design_detail, :notice => 'Default design detail was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @default_design_detail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /default_design_details/1
  # DELETE /default_design_details/1.xml
  def destroy
    @default_design_detail = DefaultDesignDetail.find(params[:id])
    @default_design_detail.destroy

    respond_to do |format|
      format.html { redirect_to(default_design_details_url) }
      format.xml  { head :ok }
    end
  end
end
