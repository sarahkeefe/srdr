class OutcomeEnrolledNumbersController < ApplicationController
  # GET /outcome_enrolled_numbers
  # GET /outcome_enrolled_numbers.xml
  def index
    @outcome_enrolled_numbers = OutcomeEnrolledNumber.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_enrolled_numbers }
    end
  end

  # GET /outcome_enrolled_numbers/1
  # GET /outcome_enrolled_numbers/1.xml
  def show
    @outcome_enrolled_number = OutcomeEnrolledNumber.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_enrolled_number }
    end
  end

  # GET /outcome_enrolled_numbers/new
  # GET /outcome_enrolled_numbers/new.xml
  def new
    @outcome_enrolled_number = OutcomeEnrolledNumber.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_enrolled_number }
    end
  end

  # GET /outcome_enrolled_numbers/1/edit
  def edit
    @outcome_enrolled_number = OutcomeEnrolledNumber.find(params[:id])
  end

  # POST /outcome_enrolled_numbers
  # POST /outcome_enrolled_numbers.xml
  def create
    @outcome_enrolled_number = OutcomeEnrolledNumber.new(params[:outcome_enrolled_number])

    respond_to do |format|
      if @outcome_enrolled_number.save
        format.html { redirect_to(@outcome_enrolled_number, :notice => 'Outcome enrolled number was successfully created.') }
        format.xml  { render :xml => @outcome_enrolled_number, :status => :created, :location => @outcome_enrolled_number }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_enrolled_number.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_enrolled_numbers/1
  # PUT /outcome_enrolled_numbers/1.xml
  def update
    @outcome_enrolled_number = OutcomeEnrolledNumber.find(params[:id])

    respond_to do |format|
      if @outcome_enrolled_number.update_attributes(params[:outcome_enrolled_number])
        format.html { redirect_to(@outcome_enrolled_number, :notice => 'Outcome enrolled number was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_enrolled_number.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_enrolled_numbers/1
  # DELETE /outcome_enrolled_numbers/1.xml
  def destroy
    @outcome_enrolled_number = OutcomeEnrolledNumber.find(params[:id])
    @outcome_enrolled_number.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_enrolled_numbers_url) }
      format.xml  { head :ok }
    end
  end
end
