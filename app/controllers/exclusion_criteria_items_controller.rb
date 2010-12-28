class ExclusionCriteriaItemsController < ApplicationController
  before_filter :require_user
  
  # GET /exclusion_criteria_items
  # GET /exclusion_criteria_items.xml
  def index
    @exclusion_criteria_items = ExclusionCriteriaItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @exclusion_criteria_items }
    end
  end

  # GET /exclusion_criteria_items/1
  # GET /exclusion_criteria_items/1.xml
  def show
    @exclusion_criteria_item = ExclusionCriteriaItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @exclusion_criteria_item }
    end
  end

  # GET /exclusion_criteria_items/new
  # GET /exclusion_criteria_items/new.xml
  def new
    @exclusion_criteria_item = ExclusionCriteriaItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @exclusion_criteria_item }
    end
  end

  # GET /exclusion_criteria_items/1/edit
  def edit
    @exclusion_criteria_item = ExclusionCriteriaItem.find(params[:id])
	
    respond_to do |format|
    	format.js{
    		render :update do |page|
    			page.replace_html 'new_ec_entry', :partial=>'exclusion_criteria_items/form'
    		end
  		}
  	end	
  end

  # POST /exclusion_criteria_items
  # POST /exclusion_criteria_items.xml
  def create
    @exclusion_criteria_item = ExclusionCriteriaItem.new(params[:exclusion_criteria_item])
	@exclusion_criteria_item.study_id = session[:study_id]
    display_num = @exclusion_criteria_item.get_display_number(session[:study_id])
	@exclusion_criteria_item.display_number = display_num
	@exclusion_criteria_item.save
				
	  respond_to do |format|
      if @exclusion_criteria_item.save
	    @exclusion_criteria = ExclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]})
        format.js {
		      render :update do |page|
				    page.replace_html 'exc_criteria_table', :partial => 'exclusion_criteria_items/table'
				    page['new_ec_form'].reset
					new_row_name = "ec_row_" + @exclusion_criteria_item.id.to_s					  
					page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
					page.replace_html 'exc_criteria_validation_message', ""
		      end
		    }
		    format.html {}
	    else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @exclusion_criteria_item.errors
				problem_html += "<li>" + i.to_s + " " + @exclusion_criteria_item.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'exc_criteria_validation_message', problem_html
				end
			}
			#format.html { render :action => "new" }
			format.xml  { render :xml => @exclusion_criteria_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /exclusion_criteria_items/1
  # PUT /exclusion_criteria_items/1.xml
  def update
    @exclusion_criteria_item = ExclusionCriteriaItem.find(params[:id])

    respond_to do |format|
      if @exclusion_criteria_item.update_attributes(params[:exclusion_criteria_item])
        @exclusion_criteria = ExclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]}, :order => "display_number ASC")
      	format.js{
          render :update do |page|
				    page.replace_html 'exc_criteria_table', :partial => 'exclusion_criteria_items/table'
				    new_row_name = "ec_row_" + @exclusion_criteria_item.id.to_s					  
						page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
						page.replace_html 'exc_criteria_validation_message', ""			
						@exclusion_criteria_item = ExclusionCriteriaItem.new		
						page.replace_html 'new_ec_entry', :partial=>'exclusion_criteria_items/form'
		      end
        }
      	format.html { redirect_to(@exclusion_criteria_item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @exclusion_criteria_item.errors
				problem_html += "<li>" + i.to_s + " " + @exclusion_criteria_item.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'exc_criteria_validation_message', problem_html
				end
			}	  
			format.html { render :action => "edit" }
			format.xml  { render :xml => @exclusion_criteria_item.errors, :status => :unprocessable_entity }
      end
    end
  end
  # DELETE /exclusion_criteria_items/1
  # DELETE /exclusion_criteria_items/1.xml
 def destroy
    @exclusion_criteria_item = ExclusionCriteriaItem.find(params[:id])
	@exclusion_criteria_item.shift_display_numbers(session[:study_id])	
    @exclusion_criteria_item.destroy
    respond_to do |format|
    	format.js {
				@exclusion_criteria = ExclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]}, :order => "display_number ASC")
		  	render :update do |page|
					page.replace_html 'exc_criteria_table', :partial => 'exclusion_criteria_items/table'	
					@exclusion_criteria_item = ExclusionCriteriaItem.new
					page.replace_html 'new_ec_entry', :partial => 'exclusion_criteria_items/form'					
		  	end
			}
    	
    	format.html { redirect_to( study_exclusion_criteria_items_path(session[:study_id]) ) }
			format.xml  { head :ok }
    end
  end
  
      def moveup
    @exclusion_criteria_item = ExclusionCriteriaItem.find(params[:exclusion_criteria_item_id])
	ExclusionCriteriaItem.move_up_this(params[:exclusion_criteria_item_id].to_i)
    respond_to do |format|
    	format.js {
				@exclusion_criteria = ExclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]}, :order => "display_number ASC")
		  	render :update do |page|
					page.replace_html 'exc_criteria_table', :partial => 'exclusion_criteria_items/table'	
					@exclusion_criteria_item =ExclusionCriteriaItem.new
					page.replace_html 'new_ec_entry', :partial => 'exclusion_criteria_items/form'					
		  	end
			}
    	format.html { redirect_to( study_exclusion_criteria_items_path(session[:study_id]) ) }
			format.xml  { head :ok }
    end
  end  
  
end
