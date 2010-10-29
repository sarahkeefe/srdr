
class PublicationsController < ApplicationController
  # GET /publications
  # GET /publications.xml
  def index
    @publications = Publication.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @publications }
    end
  end

  # GET /publications/1
  # GET /publications/1.xml
  def show
    @publication = Publication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publication }
    end
  end

  # GET /publications/new
  # GET /publications/new.xml
  def new
    @publication = Publication.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @publication }
    end
  end

  # GET /publications/1/edit
  def edit
    @publication = Publication.find(params[:id])
	@primary_publication = Publication.where(:study_id => params[:study_id], :is_primary => :true).one	
  end

  # POST /publications
  # POST /publications.xml
  def create
    @publication = Publication.new(params[:publication])
	if params[:publication][:is_primary] == true
		@existing_pub = Publication.where(:study_id => session[:study_id], :is_primary => true)
		if !@existing_pub.nil?
			@existing_pub.destroy
		end
	end
	
    respond_to do |format|
      if @publication.save && params[:publication][:is_primary] == "false"
	  @secondary_publications = Publication.find(:all, :conditions => {:is_primary => false, :study_id => session[:study_id]})
        format.js {
		  render :update do |page|
				page.replace_html 'secondary_publication_table', :partial => 'publications/table'
		  end
		}
      elsif @publication.save
        format.html { redirect_to(@publication, :notice => 'Publication was successfully created.') }
        format.xml  { render :xml => @publication, :status => :created, :location => @publication }	  
	  else
        format.html { render :action => "new" }
        format.xml  { render :xml => @publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /publications/1
  # PUT /publications/1.xml
  def update
    @publication = Publication.find(params[:id])

    respond_to do |format|
      if @publication.update_attributes(params[:publication])
        format.html { redirect_to(@publication, :notice => 'Publication was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.xml
  def destroy
    @publication = Publication.find(params[:id])
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to(publications_url) }
      format.xml  { head :ok }
    end
  end
end
