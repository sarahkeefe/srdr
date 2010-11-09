
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
      format.js{
      	  render :update do |page|
      	  	page.replace_html 'secondary_publication_entry', :partial => 'publications/form'
      	  end
  	  }
		format.html # new.html.erb
		format.xml  { render :xml => @publication }
    end
  end

  # GET /publications/1/edit
  def edit
    @publication = Publication.find(params[:id])
	  respond_to do |format|
      format.js {
		  	render :update do |page|
					page.replace_html 'secondary_publication_entry', :partial => 'publications/edit_secondary_form'
			  end
		  }
	  end
	end
  
  # POST /publications
  # POST /publications.xml
  def create
  @publication = Publication.new(params[:publication])
	@publication.study_id = session[:study_id]
	if params[:publication][:is_primary] == true
		@existing_pub = Publication.where(:study_id => session[:study_id], :is_primary => true)
		if !@existing_pub.nil?
			@existing_pub.destroy
		end
	end
	if params[:is_primary] == 'true'
			@publication.is_primary = TRUE
			@study = Study.find(session[:study_id])
			@study.title = @publication.title
			@study.save
		else
			@publication.is_primary = FALSE
		end
    respond_to do |format|
      if @publication.save && params[:is_primary] == 'false'
	  	  @secondary_publications = Publication.find(:all, :conditions => {:is_primary => false, :study_id => session[:study_id]})
        format.js {
		  		render :update do |page|
					  page.replace_html 'secondary_publication_table', :partial => 'publications/table'
					  page['secondary_pub_form'].reset
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
    @publication.study_id = session[:study_id]
    
    if(params[:is_primary] == "true")
    	@publication.is_primary = TRUE
			@study = Study.find(session[:study_id])
			@study.title = @publication.title
			@study.save		
    else
    	@publication.is_primary = FALSE
    end
    respond_to do |format|
      if @publication.update_attributes(params[:publication])
        format.js { 
      	  @secondary_publications = Publication.find(:all, :conditions => {:is_primary => false, :study_id => session[:study_id]})
          render :update do |page|
            page.replace_html 'secondary_publication_table', :partial=>'publications/table'
            #page.replace_html 'secondary_publication_entry', :partial=>'publications/form'
          end
        }
        format.html { redirect_to(project_study_publication_path(session[:project_id],session[:study_id],@publication), :notice => 'Publication was successfully updated.') }
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
      # The AJAX call in this case is used to refresh the table of secondary publications
		  # The format.js block below is taking care of this.
    	format.js { 
      	  @secondary_publications = Publication.find(:all, :conditions => {:is_primary => false, :study_id => session[:study_id]})
          render :update do |page|
            page.replace_html 'secondary_publication_table', :partial=>'publications/table'
            
            # if we're in the js index function it means we're probably coming from a deletion
            # in that case we want to be sure that if they were editing a record at the time of deletion,
            # that we remove it, create a new publication and get rid of the editing form.        
            @publication = Publication.new
            page.replace_html 'secondary_publication_entry',:partial=>'publications/form'
          end
      }
    	format.html { redirect_to(publications_url) }
      format.xml  { head :ok }
    end
  end
end
