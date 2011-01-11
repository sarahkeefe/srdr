class PrimaryPublicationNumbersController < ApplicationController
  # GET /primary_publication_numbers
  # GET /primary_publication_numbers.xml
  def index
    @primary_publication_numbers = PrimaryPublicationNumber.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @primary_publication_numbers }
    end
  end

  # GET /primary_publication_numbers/1
  # GET /primary_publication_numbers/1.xml
  def show
    @primary_publication_number = PrimaryPublicationNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @primary_publication_number }
    end
  end

  # GET /primary_publication_numbers/new
  # GET /primary_publication_numbers/new.xml
  def new
    @primary_publication_number = PrimaryPublicationNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @primary_publication_number }
    end
  end

  # GET /primary_publication_numbers/1/edit
  def edit
    @primary_publication_number = PrimaryPublicationNumber.find(params[:id])
  end

  # POST /primary_publication_numbers
  # POST /primary_publication_numbers.xml
  def create
    @primary_publication_number = PrimaryPublicationNumber.new(params[:primary_publication_number])

    respond_to do |format|
      if @primary_publication_number.save
        format.html { redirect_to(@primary_publication_number, :notice => 'Primary publication number was successfully created.') }
        format.xml  { render :xml => @primary_publication_number, :status => :created, :location => @primary_publication_number }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @primary_publication_number.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /primary_publication_numbers/1
  # PUT /primary_publication_numbers/1.xml
  def update
    @primary_publication_number = PrimaryPublicationNumber.find(params[:id])

    respond_to do |format|
      if @primary_publication_number.update_attributes(params[:primary_publication_number])
        format.html { redirect_to(@primary_publication_number, :notice => 'Primary publication number was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @primary_publication_number.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /primary_publication_numbers/1
  # DELETE /primary_publication_numbers/1.xml
  def destroy
    @primary_publication_number = PrimaryPublicationNumber.find(params[:id])
    @primary_publication_number.destroy

    respond_to do |format|
      format.html { redirect_to(primary_publication_numbers_url) }
      format.xml  { head :ok }
    end
  end
end
