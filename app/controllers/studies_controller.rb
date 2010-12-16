class StudiesController < ApplicationController
  layout "studies"
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
		@study_qs = StudiesKeyQuestion.where(:study_id => @study.id).all
		@study_questions = []
		@study_qs.each{|i| @study_questions << KeyQuestion.find(i.key_question_id)}	  
		@primary_publication = @study.get_primary_publication.nil? ? Publication.new : @study.get_primary_publication
		@secondary_publications = @study.get_secondary_publications
		@arms = Arm.where(:study_id => @study.id).all
		@population_characteristics = PopulationCharacteristic.where(:study_id => @study.id).all
		@outcomes = Outcome.where(:study_id => @study.id).all
		@adverse_events = AdverseEvent.where(:study_id => @study.id).all
		@quality_aspects = QualityAspect.where(:study_id => @study.id).all
		@quality_rating = QualityRating.where(:study_id => @study.id).first
		
		@analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=?", @study.id], :order=>"outcome_id")
		@outcomes_analyzed = @analyses.collect{|an| an.outcome_id }
		@outcomes_analyzed = @outcomes_analyzed.uniq
		
		@outcomes = Outcome.where(:study_id => @study.id).all
		# get the study title, which is the same as the primary publication for the study
		@study_title = Publication.where(:study_id => @study.id, :is_primary => true).first
		@study_title = @study_title.nil? ? "" : @study_title.title.to_s
	  
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
	  @inclusion_criteria = InclusionCriteriaItem.where(:study_id => @study.id).order("display_number ASC")
	  @inclusion_criteria_item = InclusionCriteriaItem.new
	  @exclusion_criteria = ExclusionCriteriaItem.where(:study_id => @study.id).order("display_number ASC")
	  @exclusion_criteria_item = ExclusionCriteriaItem.new
	  @arm = Arm.new
	  @arms = Arm.where(:study_id => @study.id).all	
	end
  
  # attributes
  # displays population attributes/characteristics data table
  def attributes
		@study = Study.find(params[:study_id])
		makeActive(@study)
		@project = Project.find(params[:project_id])
		@study_arms = Arm.where(:study_id => @study.id).all
		@population_characteristics = PopulationCharacteristic.where(:study_id => @study.id).all
		@population_characteristics.sort_by(&:category_title)
		@population_characteristic_data_point = PopulationCharacteristicDataPoint.new
		@population_characteristic = PopulationCharacteristic.new
		@population_characteristic_data = PopulationCharacteristicDataPoint.where(:study_id => @study.id).all
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
	@study_arms = Arm.where(:study_id => params[:study_id]).all
	@outcome = Outcome.new
	@outcomes = Outcome.where(:study_id => params[:study_id]).all
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
	@study_arms = Arm.where(:study_id => params[:study_id]).all
	@study_arm_ids = @study_arms.collect{|arm| arm.id}
	@study_arm_ids = @study_arm_ids.to_json
	@outcomes = Outcome.where(:study_id => params[:study_id]).all
	@first_outcome = @outcomes[0]
	if !@first_outcome.nil?
		@first_subgroups = Outcome.get_subgroups_array(@first_outcome.id)
		@first_timepoints = Outcome.get_timepoints_array(@first_outcome.id)
		current_selections = OutcomeResult.get_selected_sg_and_tp(@first_subgroups, @first_timepoints)
		@selected_subgroup = current_selections[0]
		@selected_timepoint = current_selections[1]
		
		# ISN'T THIS THE SAME AS @first_outcome???
		@selected_outcome_object = Outcome.find(@first_outcome.id)
		@selected_outcome_object_results = OutcomeResult.get_selected_outcome_results(@first_outcome.id, @selected_subgroup, @selected_timepoint)
		
		# gather any footnotes for the first selections
		@footnotes = Footnote.where(:study_id=>session[:study_id], :outcome_id=>@first_outcome.id,
															  :subgroup_id=>@selected_subgroup, :timepoint_id=>@selected_timepoint).order("note_number ASC")
	else
		@selected_subgroup = nil
		@selected_timepoint = nil
		@selected_outcome_object = nil
		@selected_outcome_object_results = nil
	end
	@outcome_column = OutcomeColumn.new
	@secondary_publications = @study.get_secondary_publications	
	render :layout => 'outcomedata'	
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
      @first_subgroup_comparisons = OutcomeAnalysis.get_analysis_subgroup_comparisons(@first_subgroups)
      
      @first_timepoints = Outcome.get_timepoints_array(@selected_outcome)
    	@first_timepoint_comparisons = OutcomeAnalysis.get_analysis_timepoint_comparisons(@first_timepoints)
      
      current_selections = OutcomeAnalysis.get_selected_analysis_sg_and_tp(@first_subgroup_comparisons, @first_timepoint_comparisons)
      @selected_subgroup = current_selections[0]
      @selected_timepoint = current_selections[1]
      
      @continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND outcome_id=? AND subgroup_comp=? AND timepoint_comp=?",
      														session[:study_id], @selected_outcome, @selected_subgroup.to_s, @selected_timepoint])
      
      @saved_analyses = OutcomeAnalysis.get_saved_analyses(session[:study_id])
      @analysis_title = OutcomeAnalysis.get_analysis_title(@outcomes[0].title, @selected_subgroup, @selected_timepoint)
 		 end
 		render :layout => 'outcomeanalysis'	 
 	end
  
  # When the outcome type is changed in the outcome analysis or data page, we have to update the 
  # other subgroup and timepoint selections accordingly. 
   def show_outcome_subgroups_and_timepoints
  	@selected_outcome_object = Outcome.find(params[:selected_outcome_id])
  	@selected_outcome = @selected_outcome_object.id
  	@outcome_subgroups = Outcome.get_subgroups_array(@selected_outcome)
  	@outcome_timepoints = Outcome.get_timepoints_array(@selected_outcome)
  	@study_arms = Arm.find(:all, :conditions=>["study_id=?",session[:study_id]], :select=>["id","title"])
  	@model_name = params[:form_type]
  	
  	if(@model_name == "outcome_analysis")
  		@outcome_timepoint_comparisons = OutcomeAnalysis.get_analysis_timepoint_comparisons(@outcome_timepoints)
		@outcome_subgroup_comparisons = OutcomeAnalysis.get_analysis_subgroup_comparisons(@outcome_subgroups)	  	
		current_selections = OutcomeAnalysis.get_selected_analysis_sg_and_tp(@outcome_subgroup_comparisons, @outcome_timepoint_comparisons)
		@selected_subgroup = current_selections[0]
  		@selected_timepoint = current_selections[1]
  		@analysis_title = OutcomeAnalysis.get_analysis_title(@selected_outcome_object.title, @selected_subgroup, @selected_timepoint)
	elsif(@model_name == "outcome_result")
	  	current_selections = OutcomeResult.get_selected_sg_and_tp(@outcome_subgroups, @outcome_timepoints)
	  	@selected_subgroup = current_selections[0]
	  	@selected_timepoint = current_selections[1]
	  	# gather any footnotes for the first selections
	end

  	respond_to do |format|
  		format.js{
  			render :update do |page|
			
  				if(@model_name == "outcome_analysis")
  					 print "SELECTED OUTCOME IS " + @selected_outcome.to_s + "-------------------\n"
  					 print "SELECTED SUBGROUP IS " + @selected_subgroup.to_s + "-------------------\n"
  					 print "SELECTED TIMEPOINT IS " + @selected_timepoint.to_s + "-------------------\n"
  					 page.replace_html 'timepoint_options',:partial => 'outcome_analyses/timepoint_selector'
  					 page.replace_html 'subgroup_options',:partial => 'outcome_analyses/subgroup_selector'
  					 @continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND outcome_id=? AND subgroup_comp=? AND timepoint_comp=? ",
      														session[:study_id], @selected_outcome.to_i, @selected_subgroup, @selected_timepoint])
    				 @new_continuous_analysis = OutcomeAnalysis.new
    				 page.replace_html 'entry_form',:partial=> 'outcome_analyses/entry_form_table'
					 
  				 elsif (@model_name == "outcome_result")
					   print "SELECTED OUTCOME IS " + @selected_outcome.to_s + "-------------------\n"
  					 print "SELECTED SUBGROUP IS " + @selected_subgroup.to_s + "-------------------\n"
  					 print "SELECTED TIMEPOINT IS " + @selected_timepoint.to_s + "-------------------\n"
  					 @study_arm_ids = @study_arms.collect{|arm| arm.id}
						 @study_arm_ids = @study_arm_ids.to_json
  					 page.replace_html 'timepoint_options',:partial => 'outcomes/timepoint_selector'
  					 page.replace_html 'subgroup_options',:partial => 'outcomes/subgroup_selector'
						 @selected_outcome_object = Outcome.find(@selected_outcome)
						 @selected_outcome_object_results = OutcomeResult.where(:subgroup_id => @selected_subgroup, :timepoint_id => @selected_timepoint, :outcome_id => @selected_outcome).first
				 		 @selected_outcome_object_results = @selected_outcome_object_results.nil? ? OutcomeResult.new : @selected_outcome_object_results
				 		
				 		 @footnotes = Footnote.where(:study_id=>session[:study_id], :outcome_id=>@selected_outcome,
															  :subgroup_id=>@selected_subgroup, :timepoint_id=>@selected_timepoint).order("note_number ASC")

						 page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
						 page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
  				end
  			end
  		}
  	end
  end
  
  # Whenever the subgroup or timepoint is chnaged on the outcome data our outcome analyses pages, 
  # the table underneath should be updated to show any existing data for those combinations or
  # to allow for new data entry.
  def update_partial
  	print "---------------------UPDATING FROM UPDATE_PARTIAL IN STUDIES ---------------------------\n"
  	print "SELECTED OUTCOME: " + params[:selected_outcome_id] + "\n"
  	print "SELECTED SUBGROUP: " + params[:selected_subgroup] + "\n"
  	print "SELECTED TIMEPOINT: " + params[:selected_timepoint] + "\n"
  	
  	print "FORM TYPE: " + params[:form_type] + "\n"
  	@selected_outcome = params[:selected_outcome_id]  # outcome id
  	@selected_subgroup = params[:selected_subgroup] # subgroup id
  	@selected_timepoint = params[:selected_timepoint]   # timepoint id
		outcome_title = Outcome.find(@selected_outcome, :select=>"title")
  	@model_name = params[:form_type]
  	
  	user_selected = ""
  	
  	# determine if a "x vs y" option has been selected. If so, we can't offer that for 
  	# other options and should reset the other selections
  	if @model_name == "outcome_analysis"
  		@outcome_subgroups = Outcome.get_subgroups_array(@selected_outcome)
  		@outcome_timepoints = Outcome.get_timepoints_array(@selected_outcome)
  		@outcome_subgroup_comparisons = OutcomeAnalysis.get_analysis_subgroup_comparisons(@outcome_subgroups, @selected_timepoint) 
  		@outcome_timepoint_comparisons = OutcomeAnalysis.get_analysis_timepoint_comparisons(@outcome_timepoints, @selected_subgroup) 
  		if @selected_timepoint =~ /\_vs\_/ && @selected_subgroup =~ /\_vs\_/ 
  			user_selected = params[:updating]
  			print "IM IN THE UPDATE PARTIAL AND WE NEED TO DO AN ALERT ----------------\n\n"
				if user_selected == "timepoint"
					@outcome_subgroup_comparisons = OutcomeAnalysis.get_analysis_subgroup_comparisons(@outcome_subgroups, @selected_timepoint) 
					@selected_subgroup = "Total"				
				elsif user_selected == "subgroup"
					@outcome_timepoint_comparisons = OutcomeAnalysis.get_analysis_timepoint_comparisons(@outcome_timepoints, @selected_subgroup) 
					@selected_timepoint = "Time_0"
				end	
		end
			@analysis_title = OutcomeAnalysis.get_analysis_title(outcome_title.title, @selected_subgroup, @selected_timepoint)
	 end
	
  	respond_to do |format|
  		format.js{
	  		render :update do |page|
  				if(@model_name == "outcome_analysis")
  				  @continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND outcome_id=? AND subgroup_comp=? AND timepoint_comp=? ",
      														session[:study_id], @selected_outcome.to_i, @selected_subgroup, @selected_timepoint])
    				@new_continuous_analysis = OutcomeAnalysis.new
    				@study_arms = Arm.find(:all, :conditions=>["study_id=?",session[:study_id]], :select=>["id","title"])
    				
    				page.replace_html 'timepoint_options',:partial => 'outcome_analyses/timepoint_selector'
    				page.replace_html 'subgroup_options',:partial => 'outcome_analyses/subgroup_selector'
    				page.replace_html 'entry_form',:partial=> 'outcome_analyses/entry_form_table'
    				
    				
  				elsif (@model_name == "outcome_result")
						@study_arms = Arm.where(:study_id => session[:study_id]).all
						@selected_outcome_object = Outcome.find(@selected_outcome)
						@selected_outcome_object_results = OutcomeResult.new
						@footnotes = Footnote.where(:study_id=>session[:study_id], :outcome_id=>@selected_outcome,
															  :subgroup_id=>@selected_subgroup, :timepoint_id=>@selected_timepoint).order("note_number ASC")
						@study_arm_ids = @study_arms.collect{|arm| arm.id}
						@study_arm_ids = @study_arm_ids.to_json
						page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
						page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'
    				
	  			end
  			end
  		}
  	end
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
	@quality_rating = @exists.nil? ? QualityRating.new : @exists

	end
  
  # GET /studies/new
  # GET /studies/new.xml
  def new
    
  	@study = Study.new
    @study.project_id = session[:project_id]
	@study.save
	makeActive(@study)

	# if there is a template variable set in the new call
	Study.set_template_id_if_exists(params, @study)
	    	
	@primary_publication = Publication.create()
	@publication=Publication.new
    @secondary_publications = []
		
	@questions = @study.get_question_choices(session[:project_id])
    render :layout => 'studydesign'	

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
		@primary_publication = @primary_publication.nil? ? Publication.create() : @primary_publication
	  
		# get info on secondary publications
		@secondary_publications = @study.get_secondary_publications
	  
		# create a new publication represented in the secondary publications form
		@publication = Publication.new
		render :layout => 'studydesign'	
  end

  # POST /studies
  # POST /studies.xml
  def create
    @study = Study.new(params[:study])
  	@study.project_id = session[:project_id]
	@project = Project.find(session[:project_id])
	Study.set_study_type(params)
    
  	makeActive(@study)
	  
    respond_to do |format|
      if @study.save
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
	@study = Study.set_study_type(params, @study)	
	
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
    @study.remove_from_key_question_junction
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
					page.replace_html 'outcome_results_list', :partial => 'outcome_results/completed_list'				
					page.replace_html 'entry_form', :partial => 'outcome_results/table'
				end
			}
		end
  end
end
