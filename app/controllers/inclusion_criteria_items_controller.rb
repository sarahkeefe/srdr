class InclusionCriteriaItemsController < ApplicationController
  # GET /inclusion_criteria_items
  # GET /inclusion_criteria_items.xml
  def index
    @inclusion_criteria_items = InclusionCriteriaItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inclusion_criteria_items }
    end
  end

  # GET /inclusion_criteria_items/1
  # GET /inclusion_criteria_items/1.xml
  def show
    @inclusion_criteria_item = InclusionCriteriaItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inclusion_criteria_item }
    end
  end

  # GET /inclusion_criteria_items/new
  # GET /inclusion_criteria_items/new.xml
  def new
    @inclusion_criteria_item = InclusionCriteriaItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inclusion_criteria_item }
    end
  end

  # GET /inclusion_criteria_items/1/edit
  def edit
    @inclusion_criteria_item = InclusionCriteriaItem.find(params[:id])
	
    respond_to do |format|
    	format.js{
    		render :update do |page|
    			page.replace_html 'new_ic_entry', :partial=>'inclusion_criteria_items/form'
    		end
  		}
  	end	
  end

  # POST /inclusion_criteria_items
  # POST /inclusion_criteria_items.xml
  def create
    @inclusion_criteria_item = InclusionCriteriaItem.new(params[:inclusion_criteria_item])
	@inclusion_criteria_item.study_id = session[:study_id]
    display_num = @inclusion_criteria_item.get_display_number(session[:study_id])
	@inclusion_criteria_item.display_number = display_num
	@inclusion_criteria_item.save
				
	  respond_to do |format|
      if @inclusion_criteria_item.save
	    @inclusion_criteria = InclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]})
        format.js {
		      render :update do |page|
				    page.replace_html 'inc_criteria_table', :partial => 'inclusion_criteria_items/table'
				    page['new_ic_form'].reset
					new_row_name = "ic_row_" + @inclusion_criteria_item.id.to_s					  
					page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
					page.replace_html 'inc_criteria_validation_message', ""
		      end
		    }
		    format.html {}
	    else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @inclusion_criteria_item.errors
				problem_html += "<li>" + i.to_s + " " + @inclusion_criteria_item.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'inc_criteria_validation_message', problem_html
				end
			}
			#format.html { render :action => "new" }
			format.xml  { render :xml => @inclusion_criteria_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inclusion_criteria_items/1
  # PUT /inclusion_criteria_items/1.xml
  def update
    @inclusion_criteria_item = InclusionCriteriaItem.find(params[:id])

    respond_to do |format|
      if @inclusion_criteria_item.update_attributes(params[:inclusion_criteria_item])
        @inclusion_criteria = InclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]})
      	format.js{
          render :update do |page|
				    page.replace_html 'inc_criteria_table', :partial => 'inclusion_criteria_items/table'
				    new_row_name = "ic_row_" + @inclusion_criteria_item.id.to_s					  
						page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
						page.replace_html 'inc_criteria_validation_message', ""			
						@inclusion_criteria_item = InclusionCriteriaItem.new		
						page.replace_html 'new_inc_criteria_entry', :partial=>'inclusion_criteria_items/form'
		      end
        }
      	format.html { redirect_to(@inclusion_criteria_item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @inclusion_criteria_item.errors
				problem_html += "<li>" + i.to_s + " " + @inclusion_criteria_item.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
					page.replace_html 'inc_criteria_validation_message', problem_html
				end
			}	  
			format.html { render :action => "edit" }
			format.xml  { render :xml => @inclusion_criteria_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inclusion_criteria_items/1
  # DELETE /inclusion_criteria_items/1.xml
 def destroy
    @inclusion_criteria_item = InclusionCriteriaItem.find(params[:id])
	@inclusion_criteria_item.shift_display_numbers(session[:study_id])	
    @inclusion_criteria_item.destroy
    respond_to do |format|
    	format.js {
				@inclusion_criteria = InclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]}, :order => "display_number ASC")
		  	render :update do |page|
					page.replace_html 'inc_criteria_table', :partial => 'inclusion_criteria_items/table'	
					@inclusion_criteria_item = InclusionCriteriaItem.new
					page.replace_html 'new_ic_entry', :partial => 'inclusion_criteria_items/form'					
		  	end
			}
    	
    	format.html { redirect_to( study_inclusion_criteria_items_path(session[:study_id]) ) }
			format.xml  { head :ok }
    end
  end
  
    def moveup
    @inclusion_criteria_item = InclusionCriteriaItem.find(params[:inclusion_criteria_item_id])
	InclusionCriteriaItem.move_up_this(params[:inclusion_criteria_item_id].to_i)
    respond_to do |format|
    	format.js {
				@inclusion_criteria = InclusionCriteriaItem.find(:all, :conditions => {:study_id => session[:study_id]}, :order => "display_number ASC")
		  	render :update do |page|
					page.replace_html 'inc_criteria_table', :partial => 'inclusion_criteria_items/table'	
					@inclusion_criteria_item =InclusionCriteriaItem.new
					page.replace_html 'new_ic_entry', :partial => 'inclusion_criteria_items/form'					
		  	end
			}
    	format.html { redirect_to( study_inclusion_criteria_items_path(session[:study_id]) ) }
			format.xml  { head :ok }
    end
  end  
  
end
