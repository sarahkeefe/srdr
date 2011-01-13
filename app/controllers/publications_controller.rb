class PublicationsController < ApplicationController
before_filter :require_user

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
 	@publication.display_number = @publication.get_display_number(session[:study_id])
	@publication.study_id = session[:study_id]
	@publication.save
	@secondary_publications = Publication.find(:all, :order => 'display_number ASC', :conditions => {:study_id => session[:study_id]})	
 
 
     respond_to do |format|
      if @publication.save
			format.js {
				render :update do |page|
					page.replace_html 'secondary_publication_table', :partial=>'publications/table'	
				end
			}
	  
        #format.html { redirect_to(@publication, :notice => 'Publication was successfully created.') }
        #format.xml  { render :xml => @publication, :status => :created, :location => @publication }
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
    respond_to do |format|
      if @publication.update_attributes(params[:publication])
			format.js { 
			  @secondary_publications = Publication.find(:all, :order => 'display_number ASC', :conditions => {:study_id => session[:study_id]})
			  render :update do |page|

						saved_html = "<div class='success_message' id='secondary_success_div'>Saved Successfully!</div><br/>"
						page.replace_html 'secondary_publication_table', :partial=>'publications/table'		
						page.replace_html 'secondary_pub_save_message',saved_html
						page.call("show_save_indication","secondary_success_div");
						page.call("show_save_indication","sec_pub_save_status_div");
						page.delay(2) do
							page['secondary_pub_form'].reset
							@publication = Publication.new  
							page.replace_html 'secondary_publication_entry', :partial=>'publications/form'		  
						end
			  end
			}
        format.html { redirect_to(project_study_publication_path(session[:project_id],session[:study_id],@publication), :notice => 'Publication was successfully updated.') }
        format.xml  { head :ok }
      else
problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @publication.errors
				problem_html += "<li>" + i.to_s + " " + @publication.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					if  params[:is_primary] == 'true'
						page.replace_html 'primary_pub_validation_message', problem_html
					else
						page.replace_html 'secondary_pub_validation_message', problem_html				
					end
				end
			}       
        format.xml  { render :xml => @publication.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1
  # DELETE /publications/1.xml
  def destroy
    @publication = Publication.find(params[:id])
	@publication.shift_display_numbers(session[:study_id])
    @publication.destroy

    respond_to do |format|
      # The AJAX call in this case is used to refresh the table of secondary publications
		  # The format.js block below is taking care of this.
    	format.js { 
      	  @secondary_publications = Publication.find(:all, :order => 'display_number ASC', :conditions => {:study_id => session[:study_id]})
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

def moveup
	@publication = Publication.find(params[:publication_id].to_i)
	Publication.move_up_this(params[:publication_id].to_i, session[:study_id])
		respond_to do |format|
			format.js { 
			  @secondary_publications = Publication.find(:all, :order => 'display_number ASC', :conditions => {:study_id => session[:study_id]})
			  render :update do |page|
					page.replace_html 'secondary_publication_table', :partial=>'publications/table'  
					@publication = Publication.new
					page.replace_html 'secondary_publication_entry',:partial=>'publications/form'
			  end
		}
		format.html { redirect_to(publications_url) }
		format.xml  { head :ok }
    end


	
end
end