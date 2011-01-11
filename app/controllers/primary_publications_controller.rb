class PrimaryPublicationsController < ApplicationController
respond_to :html, :js

  # GET /primary_publications/new
  # GET /primary_publications/new.xml
  def new
    @primary_publication = PrimaryPublication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @primary_publication }
    end
  end

  # GET /primary_publications/1/edit
  def edit
    @primary_publication = PrimaryPublication.find(params[:id])
  end

  # POST /primary_publications
  # POST /primary_publications.xml
  def create
    @primary_publication = PrimaryPublication.new(params[:primary_publication])
	@primary_publication.study_id = session[:study_id]
    respond_to do |format|
	format.html { render :action => "new" }
        format.xml  { render :xml => @primary_publication.errors, :status => :unprocessable_entity }
      if @primary_publication.save
		format.js{
			render :update do |page|
				saved_html = "<div class='success_message' id='secondary_success_div' style='display:none;'>Saved Successfully!</div><br/>"
				page.replace_html 'primary_pub_save_message', saved_html
			end
		}
		else

        #format.html { redirect_to(@primary_publication, :notice => 'Primary publication was successfully created.') }
        #format.xml  { render :xml => @primary_publication, :status => :created, :location => @primary_publication }

        format.html { render :action => "new" }
        format.xml  { render :xml => @primary_publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /primary_publications/1
  # PUT /primary_publications/1.xml
  def update
    @primary_publication = PrimaryPublication.find(params[:id])

    respond_to do |format|
      if @primary_publication.update_attributes(params[:primary_publication])
        format.html { redirect_to(@primary_publication, :notice => 'Primary publication was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @primary_publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /primary_publications/1
  # DELETE /primary_publications/1.xml
  def destroy
    @primary_publication = PrimaryPublication.find(params[:id])
    @primary_publication.destroy

    respond_to do |format|
      format.html { redirect_to(primary_publications_url) }
      format.xml  { head :ok }
    end
  end
end
