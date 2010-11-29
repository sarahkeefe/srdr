class StudiesController < ApplicationController
  # GET /studies
  # GET /studies.xml
  def index
    @studies = Study.where(:project_id => params[:project_id])
	  @project = Project.find(params[:project_id])	
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @studies }
    end
  end

  # GET /studies/1
  # GET /studies/1.xml
  def show
    @study = Study.find(params[:id])
	  @project = Project.find(session[:project_id])
	  @study_qs = StudiesKeyQuestion.where(:study_id => @study.id)
	  @study_questions = []
	  for i in @study_qs
		  @study_questions << KeyQuestion.find(i.key_question_id)
	  end
	  @primary_publication = @study.get_primary_publication
	  if @primary_publication.nil?
		@primary_publication = Publication.new
	  end
	  @secondary_publications = @study.get_secondary_publications
	  @arms = Arm.find(:all, :conditions => {:study_id => @study.id})
	  @population_characteristics = PopulationCharacteristic.where(:study_id => @study.id)
	  @outcomes = Outcome.where(:study_id => @study.id)
	  @adverse_events = AdverseEvent.where(:study_id => @study.id)
	  @quality_aspects = QualityAspect.where(:study_id => @study.id)
	  @quality_rating = QualityRating.find(:all, :conditions => {:study_id => @study.id}).first
	  @analyses = OutcomeAnalysis.where(:study_id => @study.id).all
	  @outcomes = Outcome.where(:study_id => @study.id).all	  
	  
	  # get the study title, which is the same as the primary publication for the study
	  @study_title = Publication.where(:study_id => @study.id, :is_primary => true).first
	  if @study_title.nil?
		@study_title = ""
	  else
		@study_title = @study_title.title.to_s
	  end
	  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study }
    end
  end

  # design
  # displays "study design" page
  # contains inclusion/exclusion criteria, notes, and arm information
  def design
	  @study = Study.find(params[:study_id])
	  makeActive(@study)
		@arm = Arm.new
	  @arms = Arm.find(:all, :conditions => {:study_id => @study.id})	
	end
  
  # attributes
  # displays population attributes/characteristics data table
  def attributes
		@study = Study.find(params[:study_id])
		makeActive(@study)
		@project = Project.find(params[:project_id])
		@study_arms = Arm.find(:all, :conditions => {:study_id => @study.id})
		@population_characteristics = PopulationCharacteristic.find(:all, :conditions => {:study_id => @study.id}, :order => :category_title)
		@population_characteristic_data_point = PopulationCharacteristicDataPoint.new
		@population_characteristics.sort_by(&:category_title)
		@population_characteristic = PopulationCharacteristic.new
		@population_characteristic_data = PopulationCharacteristicDataPoint.where(:study_id => @study.id)
		@population_characteristic_subcategories = PopulationCharacteristicSubcategory.where(:population_characteristic_id => @population_characteristic.id).all
		@population_characteristic_subcategory = PopulationCharacteristicSubcategory.new
		render :layout => 'attributes'		
  end
  
  # outcomesetup
  # displays form to add new outcomes, subform to add timepoints to outcomes,
  # and table to display, edit, delete existing outcomes
  def outcomesetup
	@study = Study.find(params[:study_id])
	makeActive(@study)
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome = Outcome.new
	@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome_timepoints = OutcomeTimepoint.where(:outcome_id => @outcome.id).all	
	@outcome_timepoint = OutcomeTimepoint.new
	render :layout => 'outcomesetup'	
  end

  # outcomedata
  # displays table for each outcome (navigated by a dropdown menu)
  # that enables data entry for each outcome timepoint and arm
  def outcomedata
	@study = Study.find(params[:study_id])
	makeActive(@study)
	@model_name="outcome_result"
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	
	@first_outcome = @outcomes[0]
  @first_subgroups = Outcome.get_subgroups_array(@first_outcome.id)
  @first_timepoints = Outcome.get_timepoints_array(@first_outcome.id)
	
	current_selections = get_selected_sg_and_tp(@first_subgroups, @first_timepoints)
    @selected_subgroup = current_selections[0]
    @selected_timepoint = current_selections[1]	
	
	@outcome_column = OutcomeColumn.new

	@selected_outcome_object = Outcome.find(@first_outcome.id)
	@selected_outcome_object_results = OutcomeResult.where(:subgroup_id => @selected_subgroup, :timepoint_id => @selected_timepoint, :outcome_id => @first_outcome.id).first
	
	if @selected_outcome_object_results.nil?
		@selected_outcome_object_results = OutcomeResult.new
	end
	render :layout => 'outcomesetup'	
	 end
  
	# outcomeanalysis
	# displays a table for (both?) categorical and continuous outcomes
	# enables data entry into that table (and saving)
  def outcomeanalysis
	  @model_name = "outcome_analysis"    
		@study_arms = Arm.find(:all, :conditions=>["study_id=?",session[:study_id]], :select=>["id","title"])
		@outcomes = Outcome.find(:all, :conditions=>["study_id=?",session[:study_id]],:select=>["id","title","description"])
		@new_continuous_analysis = OutcomeAnalysis.new
	 	unless @outcomes.empty?
	  	
      @selected_outcome = @outcomes[0].id
      @first_subgroups = Outcome.get_subgroups_array(@selected_outcome)
      @first_timepoints = Outcome.get_timepoints_array(@selected_outcome)
    
      current_selections = get_selected_sg_and_tp(@first_subgroups, @first_timepoints)
      @selected_subgroup = current_selections[0]
      @selected_timepoint = current_selections[1]
      @continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND outcome_id=? AND subgroup_id=? AND timepoint_id=? ",
      														session[:study_id], @selected_outcome, @selected_subgroup, @selected_timepoint])
   	end
  end
  
  # Return the ids for selected subgroup and timepoint in outcomedata or
  # outcomeanalysis pages. 
  # Params: arrays of subgroups and timepoints
  # Returns: an array containing subgroup id and timepoint id
  def get_selected_sg_and_tp(subgroups, timepoints)
  	print "GETTING THE SELECTIONS NOW -----------------\n"
  	selected_subgroup = 0
    selected_timepoint = 0
    retVal = Array.new
    unless subgroups.empty?
    	selected_subgroup = subgroups[0].id
    end
    unless timepoints.empty?
    	selected_timepoint = timepoints[0].id
    end
    retVal = [selected_subgroup, selected_timepoint]
    print "RETVAL IS: " + selected_subgroup.to_s + ", " + selected_timepoint.to_s + "._________________\n"
    return retVal
  end

  def adverseevents
		@study = Study.find(params[:study_id])
		@project = Project.find(params[:project_id])
		@adverse_events = AdverseEvent.where(:study_id => params[:study_id]).all
		@adverse_event = AdverseEvent.new
  end
  
   def quality
	@study = Study.find(params[:study_id])
	session[:study_id] = @study.id
	@project = Project.find(params[:project_id])
	@quality_aspects = QualityAspect.where(:study_id => params[:study_id]).all	
	@quality_aspect = QualityAspect.new
	@exists = QualityRating.where(:study_id => session[:study_id]).first
	if !@exists.nil?
		@quality_rating = @exists
	else
		@quality_rating = QualityRating.new
	end
	end
  
  # GET /studies/new
  # GET /studies/new.xml
  def new
    
  	@study = Study.new
    @study.project_id = session[:project_id]
	  @study.save
	  makeActive(@study)
	  template_id = ""
	  # if there is a template variable set in the new call
	  if params.keys.include?("template")
	  	template_id = params[:template]
	  	@study.get_template_setup(template_id)
	  end
	    	
	  @primary_publication = Publication.create()
	  @publication=Publication.new
    @secondary_publications = []
		
	  @questions = @study.get_question_choices(session[:project_id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study }
    end
  end

  # GET /studies/1/edit
  def edit
    @study = Study.find(params[:id])
	  @project = Project.find(params[:project_id])	
		makeActive(@study)
		  
    # get info on questions addressed
    @questions = @study.get_question_choices(session[:project_id])
    @checked_ids = @study.get_addressed_ids
		
    # get info on primary publication
	  @primary_publication = @study.get_primary_publication
    if @primary_publication.nil?
		  @primary_publication = Publication.create()
	  end
	  
	  # get info on secondary publications
	  @secondary_publications = @study.get_secondary_publications
	  
	  # create a new publication represented in the secondary publications form
	  @publication = Publication.new
  end

  # POST /studies
  # POST /studies.xml
  def create
    @study = Study.new(params[:study])
  	@study.project_id = session[:project_id]
	  @project = Project.find(session[:project_id])	
    
  	if params.keys.include?("study")
    	@study.study_type = params[:study][:study_type]
    end
    
  	makeActive(@study)
    #questions = get_questions_params(params)
	  
    respond_to do |format|
      if @study.save
      	#@study.assign_questions(questions)
      	format.html { redirect_to(@study, :notice => 'Study was successfully created.') }
        format.xml  { render :xml => @study, :status => :created, :location => @study }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /studies/1
  # PUT /studies/1.xml
  def update
    @study = Study.find(params[:id])
	@project = Project.find(session[:project_id])	
		if params.keys.include?("study")
    	@study.study_type = params[:study][:study_type]
    end
    respond_to do |format|
      if @study.update_attributes(params[:study])
	  	  questions_flag = false
      	questions = get_questions_params(params)
	      unless questions.empty?
	      	
	  	  	@study.assign_questions(questions)	  
	  	  	format.js{
	  	  	  render :update do |page|
			success_html = "<div class='success_message' style='vertical-align:text-top; display:inline'>Saved</div>"
			page.replace_html 'key_question_validation_message', success_html
	  	  	  	page['key_question_validation_message'].visual_effect(:appear)
				page['key_question_validation_message'].visual_effect(:fade)
	  	  	  end
  	  	  }
  	  	end
	  	  
	  	  format.html { redirect_to(@study, :notice => 'Study was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @study.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.xml
  def destroy
    @study = Study.find(params[:id])
    @study.destroy

    respond_to do |format|
      format.html { redirect_to(project_studies_path(session[:project_id])) }
      format.xml  { head :ok }
    end
  end
  
  def clearSessionStudyInfo
  	session[:study_id] = nil
  	session[:study_title] = nil
  end
  
  def makeActive myStudy
  	clearSessionStudyInfo()
  	session[:study_id] = myStudy.id
  	session[:study_title] = myStudy.title
  end
  
  def get_questions_params(form_params)
  	questions = Array.new
  	form_params.keys.each do |key|
  		if key =~ /^question_/
  			questions.push(key.sub(/question_/,""))
  		end
  	end
  	return questions
  end

  def show_outcome
		@outcome_result = OutcomeResult.new
		@study_arms = Arm.where(:study_id => session[:study_id]).all
		@selected_outcome = Outcome.find(params[:selected_outcome_id])	
		  respond_to do |format|
				format.js{	
					render :update do |page|
						page.replace_html 'entry_form', :partial => 'outcome_results/table'
					end
				}
		end
  end
  
  def show_outcome_subgroups_and_timepoints
  	print "IM IN SHOW_OUTCOME_SUBGRUOPS_AND_TIMEPIONTS SHOWING THINGS NOW ------------\n"
  	@selected_outcome_object = Outcome.find(params[:selected_outcome_id])
  	@selected_outcome = @selected_outcome_object.id
  	@outcome_subgroups = OutcomeSubgroup.where(:outcome_id=>@selected_outcome).all
  	@outcome_timepoints = OutcomeTimepoint.where(:outcome_id=>@selected_outcome).all
  	current_selections = get_selected_sg_and_tp(@outcome_subgroups, @outcome_timepoints)
  	@selected_subgroup = current_selections[0]
  	@selected_timepoint = current_selections[1]
  	@model_name = params[:form_type]
  	print "SELECTED SUBGROUP IS " + @selected_subgroup.to_s + "-------------------\n"
  	print "SELECTED TIMEPOINT IS " + @selected_timepoint.to_s + "-------------------\n"
  	respond_to do |format|
  		format.js{
  			render :update do |page|
  				page.replace_html 'timepoint_options',:partial => 'outcomes/timepoint_selector'
  				page.replace_html 'subgroup_options',:partial => 'outcomes/subgroup_selector'
  				if(@model_name == "outcome_analysis")
  					 @continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND outcome_id=? AND subgroup_id=? AND timepoint_id=? ",
      														session[:study_id], @selected_outcome.to_i, @selected_subgroup.to_i, @selected_timepoint.to_i])
    				 @new_continuous_analysis = OutcomeAnalysis.new
    				 @study_arms = Arm.find(:all, :conditions=>["study_id=?",session[:study_id]], :select=>["id","title"])
    				 page.replace_html 'entry_form',:partial=> 'outcome_analyses/entry_form_table'
				elsif (@model_name == "outcome_result")
					@study_arms = Arm.where(:study_id => session[:study_id]).all
					@selected_outcome_object = Outcome.find(@selected_outcome)
					@selected_outcome_object_results = OutcomeResult.where(:subgroup_id => @selected_subgroup.to_i, :timepoint_id => @selected_timepoint.to_i, :outcome_id => @selected_outcome).first
					
					if @selected_outcome_object_results.nil?
						@selected_outcome_object_results = OutcomeResult.new
					end
					page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
  				end
  			end
  		}
  	end
  end
  def update_partial
  	print "---------------------UPDATING FROM UPDATE_PARTIAL IN STUDIES ---------------------------\n"
  	print "SELECTED OUTCOME: " + params[:selected_outcome_id] + "\n"
  	print "SELECTED SUBGROUP: " + params[:selected_subgroup] + "\n"
  	print "SELECTED TIMEPOINT: " + params[:selected_timepoint] + "\n"
  	print "FORM TYPE: " + params[:form_type] + "\n"

  	coming_from = params[:form_type]
  	@selected_outcome = params[:selected_outcome_id]  # outcome id
  	@selected_subgroup = params[:selected_subgroup] # subgroup id
  	@selected_timepoint = params[:selected_timepoint]   # timepoint id
  	@model_name = params[:form_type]
  	respond_to do |format|
  		format.js{
	  		render :update do |page|
  				if(coming_from == "outcome_analysis")
	  				#page.replace_html 'timepoint_options',:partial => 'outcomes/timepoint_selector'
  				  #page.replace_html 'subgroup_options',:partial => 'outcomes/subgroup_selector'
  				  @continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND outcome_id=? AND subgroup_id=? AND timepoint_id=? ",
      														session[:study_id], @selected_outcome.to_i, @selected_subgroup.to_i, @selected_timepoint.to_i])
    				@new_continuous_analysis = OutcomeAnalysis.new
    				@study_arms = Arm.find(:all, :conditions=>["study_id=?",session[:study_id]], :select=>["id","title"])
    				page.replace_html 'entry_form',:partial=> 'outcome_analyses/entry_form_table'
  				elsif (coming_from == "outcome_result")
					@study_arms = Arm.where(:study_id => session[:study_id]).all
					@selected_outcome_object = Outcome.find(@selected_outcome)
					@selected_outcome_object_results = OutcomeResult.where(:subgroup_id => @selected_subgroup.to_i, :timepoint_id => @selected_timepoint.to_i, :outcome_id => @selected_outcome.to_i).first
	
					if @selected_outcome_object_results.nil?
						@selected_outcome_object_results = OutcomeResult.new
					end
					page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
	  				#update_outcome_data_table(@selected_outcome.to_s,@selected_subgroup.to_s,@selected_timepoint.to_s,page)
	  			end
  			end
  		}
  	end
  end
  
  def update_outcome_analysis_table
    print "OK WE HAVE TO UPDATE THE ANALYSIS TABLE NOW!"	
    #@continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND outcome_id=? AND subgroup_id=? AND timepoint_id=? ",
    #  														session[:study_id], oc_id, sg_id, tp_id])
    #@new_continuous_analysis = OutcomeAnalysis.new
    #page.replace_html 'entry_form',:partial=> 'outcome_analyses/entry_form_table'
  end
  def update_outcome_data_table
  
  end
end
