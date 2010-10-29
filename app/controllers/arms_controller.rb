class ArmsController < ApplicationController
  # GET /arms
  # GET /arms.xml
  def index
    @arms = Arm.all
    
		respond_to do |format|
			# if we're coming in as an AJAX call it's most likely from the destroy method
    	# in that case, update the list of key questions and create a new one to reset
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
    	format.html # index.html.erb
      format.xml  { render :xml => @arms }
    end
  end

  # GET /arms/1
  # GET /arms/1.xml
  def show
    @arm = Arm.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @arm }
    end
  end

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
		      end
		    }
		    format.html {}
	    else
        format.html { render :action => "new" }
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
		      end
        }
      	format.html { redirect_to(@arm, :notice => 'Arm was successfully updated.') }
        format.xml  { head :ok }
      else
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
      format.html { redirect_to( study_arms_path(session[:study_id]) ) }
		
	  	format.html { redirect_to(arms_url) }
    	format.xml  { head :ok }
    end
  end
end
