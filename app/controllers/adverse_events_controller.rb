class AdverseEventsController < ApplicationController
  # GET /adverse_events/new
  # GET /adverse_events/new.xml
  def new
    @adverse_event = AdverseEvent.new

    respond_to do |format|
    	format.js{
    		render :update do |page|
    			page.replace_html 'adverse_event_entry', :partial => 'adverse_events/form'
    		end	
  		}
    	format.html # new.html.erb
      format.xml  { render :xml => @adverse_event }
    end
  end

  # GET /adverse_events/1/edit
  def edit
    @adverse_event = AdverseEvent.find(params[:id])
    respond_to do |format|
    	format.js{
    	  render :update do |page| 
    			page.replace_html 'adverse_event_entry', :partial => 'adverse_events/edit_form'    	
    		end
  		}
    end
  end

  # POST /adverse_events
  # POST /adverse_events.xml
  def create
    @adverse_event = AdverseEvent.new(params[:adverse_event])
	@study = Study.find(session[:study_id])
	 display_num = @adverse_event.get_display_number(session[:study_id])
	@adverse_event.display_number = display_num
	@adverse_event.save
	
    respond_to do |format|
      if @adverse_event.save
        format.js{
          @adverse_events = AdverseEvent.find(:all, :conditions=>['study_id=?',session[:study_id]])
          render :update do |page|
          	page.replace_html 'adverse_events_table', :partial => 'adverse_events/table'
          	new_row_name = 'adverse_event_' + @adverse_event.id.to_s
          	page['new_adverse_event_form'].reset
			page.replace_html 'adverse_event_validation_message', ""			
          	page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})					
          end	
        }
      	format.html { redirect_to(@adverse_event, :notice => 'Adverse event was successfully created.') }
        format.xml  { render :xml => @adverse_event, :status => :created, :location => @adverse_event }
      else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @adverse_event.errors
				problem_html += "<li>" + i.to_s + " " + @adverse_event.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
						page.replace_html 'adverse_event_validation_message', problem_html
				end
			}     	  
        format.html { render :action => "new" }
        format.xml  { render :xml => @adverse_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /adverse_events/1
  # PUT /adverse_events/1.xml
  def update
    @adverse_event = AdverseEvent.find(params[:id])

    respond_to do |format|
      if @adverse_event.update_attributes(params[:adverse_event])
        @adverse_events = AdverseEvent.find(:all, :conditions=>['study_id=?',session[:study_id]])
      	format.js { 
        	render :update do |page|
        		page.replace_html 'adverse_events_table', :partial => 'adverse_events/table'
          	new_row_name = 'adverse_event_' + @adverse_event.id.to_s
						page.replace_html 'adverse_event_validation_message', ""			
          	page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
						
						#reset the entry form
						@adverse_event = AdverseEvent.new
						page.replace_html 'adverse_event_entry', :partial => 'adverse_events/form'
        	end
        }
      	format.html { redirect_to(@adverse_event, :notice => 'Adverse event was successfully updated.') }
        format.xml  { head :ok }
      else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @adverse_event.errors
				problem_html += "<li>" + i.to_s + " " + @adverse_event.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
						page.replace_html 'adverse_event_validation_message', problem_html
				end
			}     	  
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adverse_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adverse_events/1
  # DELETE /adverse_events/1.xml
  def destroy
    @adverse_event = AdverseEvent.find(params[:id])
	@adverse_event.shift_display_numbers(session[:study_id])		
    @adverse_event.destroy
		
    respond_to do |format|
    	format.js {
				@adverse_events = AdverseEvent.find(:all, :conditions=>['study_id=?',session[:study_id]])		
		  	render :update do |page|
					page.replace_html 'adverse_events_table', :partial => 'adverse_events/table'	
					@adverse_event = AdverseEvent.new
					page.replace_html 'adverse_event_entry', :partial => 'adverse_events/form'					
		  	end
			}
      format.html { redirect_to(adverse_events_url) }
      format.xml  { head :ok }
    end
  end
end
