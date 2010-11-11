class QualityAspectsController < ApplicationController
  # GET /quality_aspects
  # GET /quality_aspects.xml
  def index
    @quality_aspects = QualityAspect.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @quality_aspects }
    end
  end

  # GET /quality_aspects/1
  # GET /quality_aspects/1.xml
  def show
    @quality_aspect = QualityAspect.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @quality_aspect }
    end
  end

  # GET /quality_aspects/new
  # GET /quality_aspects/new.xml
  def new
    @quality_aspect = QualityAspect.new

    respond_to do |format|
    	format.js{
    		render :update do |page|
    			page.replace_html 'quality_aspect_entry', :partial => 'quality_aspects/form'
    		end	
  		}	
      format.html # new.html.erb
      format.xml  { render :xml => @quality_aspect }
    end
  end

  # GET /quality_aspects/1/edit
  def edit
    @quality_aspect = QualityAspect.find(params[:id])
    respond_to do |format|	
    	format.js{
    	  render :update do |page| 
    			page.replace_html 'quality_aspect_entry', :partial => 'quality_aspects/edit_form'    	
    		end
  		}
	end
  end

  # POST /quality_aspects
  # POST /quality_aspects.xml
  def create
    @quality_aspect = QualityAspect.new(params[:quality_aspect])

    respond_to do |format|
      if @quality_aspect.save
	@quality_aspects = QualityAspect.where(:study_id => session[:study_id]).all		  
       format.js{
          render :update do |page|
          	page.replace_html 'quality_aspects_table', :partial => 'quality_aspects/table'
          	new_row_name = 'quality_aspect_' + @quality_aspect.id.to_s
          	page['new_quality_aspect_form'].reset
          	page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
          end	
        }
        format.html { redirect_to(@quality_aspect, :notice => 'Quality aspect was successfully created.') }
        format.xml  { render :xml => @quality_aspect, :status => :created, :location => @quality_aspect }
      else
problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @quality_aspect.errors
				problem_html += "<li>" + i.to_s + " " + @quality_aspect.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
						page.replace_html 'quality_aspect_validation_message', problem_html
				end
			}     	  	  
        format.html { render :action => "new" }
        format.xml  { render :xml => @quality_aspect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quality_aspects/1
  # PUT /quality_aspects/1.xml
  def update
    @quality_aspect = QualityAspect.find(params[:id])
	
    respond_to do |format|
      if @quality_aspect.update_attributes(params[:quality_aspect])
		@quality_aspects = QualityAspect.find(:all, :conditions=>['study_id=?',session[:study_id]])
      	format.js { 
        	render :update do |page|
        		page.replace_html 'quality_aspects_table', :partial => 'quality_aspects/table'
          	new_row_name = 'quality_aspect_' + @quality_aspect.id.to_s
          	page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
        	end
        }	  
        format.html { redirect_to(@quality_aspect, :notice => 'Quality aspect was successfully updated.') }
        format.xml  { head :ok }
      else
			problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
			for i in @quality_aspect.errors
				problem_html += "<li>" + i.to_s + " " + @quality_aspect.errors[i][0] + "</li>"
			end
			problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
			format.html {
				render :update do |page| 
						page.replace_html 'quality_aspect_validation_message', problem_html
				end
			}     	  	  
        format.html { render :action => "edit" }
        format.xml  { render :xml => @quality_aspect.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quality_aspects/1
  # DELETE /quality_aspects/1.xml
  def destroy
    @quality_aspect = QualityAspect.find(params[:id])
    @quality_aspect.destroy

    respond_to do |format|
    	format.js {
				@quality_aspects = QualityAspect.find(:all, :conditions=>['study_id=?',session[:study_id]])		
		  	render :update do |page|
					page.replace_html 'quality_aspects_table', :partial => 'quality_aspects/table'	
					@quality_aspect = QualityAspect.new
					#page.replace_html 'quality_aspect_entry', :partial => 'quality_aspects/form'					
		  	end
			}	
      format.html { redirect_to(quality_aspects_url) }
      format.xml  { head :ok }
    end
  end
end
