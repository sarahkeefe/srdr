class PublicationNumbersController < ApplicationController
  # GET /publication_numbers
  # GET /publication_numbers.xml
  def index
    @publication_numbers = PublicationNumber.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @publication_numbers }
    end
  end

  # GET /publication_numbers/1
  # GET /publication_numbers/1.xml
  def show
    @publication_number = PublicationNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publication_number }
    end
  end

  # GET /publication_numbers/new
  # GET /publication_numbers/new.xml
  def new
    @publication_number = PublicationNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @publication_number }
    end
  end

  # GET /publication_numbers/1/edit
  def edit
    @publication_number = PublicationNumber.find(params[:id])
  end

  # POST /publication_numbers
  # POST /publication_numbers.xml
  def create
    @publication_number = PublicationNumber.new(params[:publication_number])

    respond_to do |format|
      if @publication_number.save
        format.html { redirect_to(@publication_number, :notice => 'Publication number was successfully created.') }
        format.xml  { render :xml => @publication_number, :status => :created, :location => @publication_number }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @publication_number.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /publication_numbers/1
  # PUT /publication_numbers/1.xml
  def update
    @publication_number = PublicationNumber.find(params[:id])

    respond_to do |format|
      if @publication_number.update_attributes(params[:publication_number])
        format.html { redirect_to(@publication_number, :notice => 'Publication number was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @publication_number.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /publication_numbers/1
  # DELETE /publication_numbers/1.xml
  def destroy
    @publication_number = PublicationNumber.find(params[:id])
    @publication_number.destroy

    respond_to do |format|
      format.html { redirect_to(publication_numbers_url) }
      format.xml  { head :ok }
    end
  end
end
