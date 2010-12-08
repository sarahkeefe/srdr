class PublicationsController < ApplicationController
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
      if @publication.save
			if params[:is_primary] == 'false'
				@secondary_publications = Publication.find(:all, :conditions => {:is_primary => false, :study_id => session[:study_id]})		  
				format.js {
					render :update do |page|
					  page.replace_html 'secondary_publication_table', :partial => 'publications/table'
						page.replace_html 'secondary_pub_validation_message', ""					  
					  page['secondary_pub_form'].reset
					 new_row_name = "pub_row_" + @publication.id.to_s					  
						page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})					  
					end	  	  	  	
				  #page['key_question_validation_message'].visual_effect(:appear)
				  #page['key_question_validation_message'].visual_effect(:fade)
					}
			elsif params[:is_primary] == 'true'
				saved_html = "<div class='success_message'>Saved!</div>"
				format.html {render :update do |page| 
					page.replace_html 'primary_pub_validation_message', saved_html
					end
					}       
				format.xml  { render :xml => @publication, :status => :created, :location => @publication }	  
			end
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
					if params[:is_primary] == 'true'
						saved_html = "<div class='success_message'>Saved!</div>"			
						page.replace_html 'primary_pub_validation_message', saved_html
					else
						page.replace_html 'secondary_publication_table', :partial=>'publications/table'			
					end
					 
	  			@publication = Publication.new  
					page.replace_html 'secondary_publication_entry', :partial=>'publications/form'
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
