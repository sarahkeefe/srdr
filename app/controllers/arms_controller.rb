class ArmsController < ApplicationController
  # GET /arms/new
  # GET /arms/new.xml
  def new
    @arm = Arm.new

    respond_to do |format|
			format.js{
    	  render :update do |page|
    	  	page.replace_html 'new_arm_entry', :partial => 'arms/form'
    	  end
  	  }
      format.html # new.html.erb
      format.xml  { render :xml => @arm }
    end
  end

  # GET /arms/1/edit
  def edit
    @arm = Arm.find(params[:id])
    
    respond_to do |format|
    	format.js{
    		render :update do |page|
    			page.replace_html 'new_arm_entry', :partial=>'arms/edit_form'
    		end
  		}
  	end
  end

  # POST /arms
  # POST /arms.xml
  def create
    @arm = Arm.new(params[:arm])
	  @arm.study_id = session[:study_id]
    
	  respond_to do |format|
      if @arm.save
	    @arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})
        format.js {
		      render :update do |page|
				    page.replace_html 'arms_table', :partial => 'arms/table'
				    page['new_arm_form'].reset
					new_row_name = "arm_row_" + @arm.id.to_s					  
					page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
					page.replace_html 'arm_validation_message', ""
		      end
		    }
		    format.html {}
	    else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @arm.errors
				problem_html += "<li>" + i.to_s + " " + @arm.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'arm_validation_message', problem_html
				end
			}
			#format.html { render :action => "new" }
			format.xml  { render :xml => @arm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /arms/1
  # PUT /arms/1.xml
  def update
    @arm = Arm.find(params[:id])

    respond_to do |format|
      if @arm.update_attributes(params[:arm])
        @arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})
      	format.js{
          render :update do |page|
				    page.replace_html 'arms_table', :partial => 'arms/table'
					new_row_name = "arm_row_" + @arm.id.to_s					  
					page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
					page.replace_html 'arm_validation_message', ""					
		      end
        }
      	format.html { redirect_to(@arm, :notice => 'Arm was successfully updated.') }
        format.xml  { head :ok }
      else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @arm.errors
				problem_html += "<li>" + i.to_s + " " + @arm.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'arm_validation_message', problem_html
				end
			}	  
			format.html { render :action => "edit" }
			format.xml  { render :xml => @arm.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /arms/1
  # DELETE /arms/1.xml
  def destroy
    @arm = Arm.find(params[:id])
    @arm.destroy
    respond_to do |format|
      # Update the list of key questions and create a new one to reset
    	# the entry form. This handles the event where the user is editing a record
    	# when they click on delete.
    	format.js {
				@arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})
		  	render :update do |page|
					page.replace_html 'arms_table', :partial => 'arms/table'	
					@arm = Arm.new
					page.replace_html 'new_arm_entry', :partial => 'arms/form'					
		  	end
			}
    	
    	format.html { redirect_to( study_arms_path(session[:study_id]) ) }
			format.xml  { head :ok }
    end
  end
end
