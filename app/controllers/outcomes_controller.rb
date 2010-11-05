class OutcomesController < ApplicationController
  # GET /outcomes
  # GET /outcomes.xml
  def index
    @outcomes = Outcome.all

    respond_to do |format|
    	format.html # index.html.erb
      format.xml  { render :xml => @outcomes }
    end
  end

  # GET /outcomes/1
  # GET /outcomes/1.xml
  def show
    @outcome = Outcome.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome }
    end
  end

  # GET /outcomes/new
  # GET /outcomes/new.xml
  def new
    @outcome = Outcome.new
	  @outcome_timepoint = OutcomeTimepoint.new
	  @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	
    respond_to do |format|
      format.js{
    	  render :update do |page|
    	  	page.replace_html 'new_outcome_entry', :partial => 'outcomes/form'
    	  end
  	  }
    	format.html # new.html.erb
      format.xml  { render :xml => @outcome }
    end
  end

  # GET /outcomes/1/edit
  def edit
    @outcome = Outcome.find(params[:id])
    @study_arms = Arm.find(:all, :select=>[:id,:title,:num_participants], :conditions => {:study_id => session[:study_id]})	
    @existing_time_points = []
	@outcome_timepoint = OutcomeTimepoint.new
    time_points = OutcomeTimepoint.where(:outcome_id => @outcome.id).all
	time_points.each do |tp|
    	@existing_time_points << tp.time_unit
    end
    
    # Get the number of participants by outcome and arm
    @numbers_enrolled = []
    @study_arms.each do |arm|
    	# i'm passing the arm id as well so that it can be used in assigning the label and form field id
    	# CHANGE THIS SO THAT WE CAN PASS AN ARRAY OF IDS TO THE FUNCTION
    	# SO THAT WE ONLY NEED TO HIT THE DATABASE ONCE
    	@numbers_enrolled << [arm.id, Outcome.getNumEnrolledByArm(@outcome.id, arm.id)]
    end      
    
   respond_to do |format|
    format.js {
		    render :update do |page|
				  page.replace_html 'new_outcome_entry', :partial => 'outcomes/edit_form'
		    end
		  }
		end
  end

  # POST /outcomes
  # POST /outcomes.xml
  def create
    @outcome = Outcome.new(params[:outcome])
	  @outcome.study_id = session[:study_id]
    
	  @outcome.save
	  
	  @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	
	  
	  for a in @study_arms
		  if !params["num_enrolled"][a.id.to_s].nil?
				@outcome_num_enrolled = OutcomeEnrolledNumber.new
				@outcome_num_enrolled.arm_id = a.id.to_s
				@outcome_num_enrolled.num_enrolled = params["num_enrolled"][a.id.to_s].to_i
				@outcome_num_enrolled.outcome_id = @outcome.id
				@outcome_num_enrolled.save
  		end

	  end
    respond_to do |format|
      if @outcome.save
		    @outcomes = Outcome.find(:all, :conditions => {:study_id => session[:study_id]})
		    @outcome_timepoints = OutcomeTimepoint.where(:outcome_id => @outcome.id).all
		    @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	  
        format.js {
		      render :update do |page|
						page.replace_html 'outcomes_table', :partial => 'outcomes/table'
						page['new_outcome_form'].reset
						new_outcome_row = "outcome_" + @outcome.id.to_s
						page[new_outcome_row].visual_effect :highlight
		  		end
				}
			else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcomes/1
  # PUT /outcomes/1.xml
  def update
    @outcome = Outcome.find(params[:id])
	#@outcome.study_id = params[:study_id]
	#@outcome.save
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})		
	for a in @study_arms
		  if !params["num_enrolled"][a.id.to_s].nil?
				if !Outcome.arm_enrolled_num_exists(@outcome.id, a.id, params["num_enrolled"][a.id.to_s])
					@outcome_num_enrolled = OutcomeEnrolledNumber.new
					@outcome_num_enrolled.arm_id = a.id.to_s
					@outcome_num_enrolled.num_enrolled = params["num_enrolled"][a.id.to_s].to_i
					@outcome_num_enrolled.outcome_id = @outcome.id
					@outcome_num_enrolled.save
				else
					#update arm enrolled number
					Outcome.update_arm_enrolled_number(@outcome.id, a.id, params["num_enrolled"][a.id.to_s])	
				end
  		end
	end
    respond_to do |format|
      if @outcome.update_attributes(params[:outcome])
		    @outcomes = Outcome.find(:all, :conditions => {:study_id => session[:study_id]})
		    @outcome_timepoints = OutcomeTimepoint.where(:outcome_id => @outcome.id).all
		    @study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})		  
        format.js{
        	render :update do |page|
						page.replace_html 'outcomes_table', :partial => 'outcomes/table'
						updated_row = "outcome_" + @outcome.id.to_s
						page[updated_row].visual_effect :highlight
		  		end  
        }
      	format.html { redirect_to(@outcome, :notice => 'Outcome was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcomes/1
  # DELETE /outcomes/1.xml
  def destroy
    @outcome = Outcome.find(params[:id])
	@outcome_tps = OutcomeTimepoint.where(:outcome_id => @outcome.id).all
    @outcome.destroy
	for i in @outcome_tps
		i.destroy
	end

    respond_to do |format|
	  @outcomes = Outcome.find(:all, :conditions => {:study_id => session[:study_id]})
		@study_arms = Arm.find(:all, :conditions => {:study_id => session[:study_id]})	  
        format.js {
		  render :update do |page|
				page.replace_html 'outcomes_table', :partial => 'outcomes/table'
		  end
		}
    end
  end
end
