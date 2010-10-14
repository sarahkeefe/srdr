class QualityRatingsController < ApplicationController
  # GET /quality_ratings
  # GET /quality_ratings.xml
  def index
    @quality_ratings = QualityRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quality_ratings }
    end
  end

  # GET /quality_ratings/1
  # GET /quality_ratings/1.xml
  def show
    @quality_rating = QualityRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quality_rating }
    end
  end

  # GET /quality_ratings/new
  # GET /quality_ratings/new.xml
  def new
    @quality_rating = QualityRating.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @quality_rating }
    end
  end

  # GET /quality_ratings/1/edit
  def edit
    @quality_rating = QualityRating.find(params[:id])
  end

  # POST /quality_ratings
  # POST /quality_ratings.xml
  def create
    @quality_rating = QualityRating.new(params[:quality_rating])

    respond_to do |format|
      if @quality_rating.save
        format.html { redirect_to(@quality_rating, :notice => 'Quality rating was successfully created.') }
        format.xml  { render :xml => @quality_rating, :status => :created, :location => @quality_rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @quality_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quality_ratings/1
  # PUT /quality_ratings/1.xml
  def update
    @quality_rating = QualityRating.find(params[:id])

    respond_to do |format|
      if @quality_rating.update_attributes(params[:quality_rating])
        format.html { redirect_to(@quality_rating, :notice => 'Quality rating was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quality_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quality_ratings/1
  # DELETE /quality_ratings/1.xml
  def destroy
    @quality_rating = QualityRating.find(params[:id])
    @quality_rating.destroy

    respond_to do |format|
      format.html { redirect_to(quality_ratings_url) }
      format.xml  { head :ok }
    end
  end
end
