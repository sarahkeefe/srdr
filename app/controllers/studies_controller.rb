class StudiesController < ApplicationController
before_filter :require_user, :except => :index
before_filter :require_user, :except => :show
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
		@project = Project.find(params[:project_id])
		@study_qs = StudiesKeyQuestion.where(:study_id => @study.id).all
		@study_questions = []
		@study_qs.each{|i| @study_questions << KeyQuestion.find(i.key_question_id)}	  
		@primary_publication = @study.get_primary_publication.nil? ? Publication.new : @study.get_primary_publication
		@secondary_publications = @study.get_secondary_publications
		@arms = Arm.where(:study_id => @study.id).all
		@study_arms = Arm.where(:study_id => @study.id).all
		@outcomes = Outcome.where(:study_id => @study.id).all
		@adverse_events = AdverseEvent.where(:study_id => @study.id).all
		@quality_aspects = QualityAspect.where(:study_id => @study.id).all
		@quality_rating = QualityRating.where(:study_id => @study.id).first
		
		@analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=?", @study.id], :order=>"outcome_id")
		@outcomes_analyzed = @analyses.collect{|an| an.outcome_id }
		@outcomes_analyzed = @outcomes_analyzed.uniq
		
		@outcomes = Outcome.where(:study_id => @study.id).all
		# get the study title, which is the same as the primary publication for the study
		@study_title = PrimaryPublication.where(:study_id => @study.id).first
		@study_title = @study_title.nil? ? "" : @study_title.title.to_s
		
		@baseline_characteristic_template_fields = BaselineCharacteristicField.where(:template_id => Study.get_template_id(@study.id)).all
		@baseline_characteristic_custom_fields = BaselineCharacteristicField.where(:study_id => @study.id).all
	  
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study }
    end
  end

   
  # GET /studies/new
  # GET /studies/new.xml
  def new    
  	@study = Study.new
  	@study.project_id = params[:project_id]
  	session[:project_id] = params[:project_id] #added this line in case the user is coming from Home
	@study.save
	makeActive(@study)
	@study_template = StudyTemplate.new
	# if there is a template variable set in the new call
	Study.set_template_id_if_exists(params, @study)
	@primary_publication = @study.get_primary_publication
	@primary_publication = @primary_publication.nil? ? PrimaryPublication.create() : @primary_publication
	render :layout => 'studydesign'	
  end

  # GET /studies/1/edit
  def edit
    @study = Study.find(params[:id])
	@project = Project.find(params[:project_id])	
	makeActive(@study)
	@study_template = StudyTemplate.where(:study_id => @study.id).first
	@study_template = @study_template.nil? ? StudyTemplate.new : @study_template
	# get the study title, which is the same as the primary publication for the study
	@study_title = PrimaryPublication.where(:study_id => @study.id).first
	@study_title = @study_title.nil? ? "" : @study_title.title.to_s
	render :layout => 'studydesign'
  end
 
 def keyquestions
    @study = Study.find(params[:study_id])
    # get info on questions addressed
    @questions = @study.get_question_choices(params[:project_id])
    @checked_ids = @study.get_addressed_ids
 end
 
 def publicationinfo
    @study = Study.find(params[:study_id]) 
    # get info on primary publication
	@primary_publication = @study.get_primary_publication
	@primary_publication = @primary_publication.nil? ? PrimaryPublication.create() : @primary_publication
	  
	# get info on secondary publications
	@secondary_publications = @study.get_secondary_publications
	@publication = Publication.new
 end
  
  # design
  # displays "study design" page
  # contains inclusion/exclusion criteria, notes, and arm information
  def design
	  @study = Study.find(params[:study_id])
	  makeActive(@study)
	  @arm = Arm.new
	  @arms = Arm.where(:study_id => @study.id).all
	end
	
def enrollment
	  @study = Study.find(params[:study_id])
	  @design_detail_field = DesignDetailField.new
	  @design_detail_data_point = DesignDetailDataPoint.new
	  @design_detail_template_fields = DesignDetailField.where(:template_id => Study.get_template_id(@study.id)).all
	  @design_detail_custom_fields = DesignDetailField.where(:study_id => @study.id).all
	  @study = Study.find(params[:study_id])
	  @inclusion_criteria = InclusionCriteriaItem.where(:study_id => @study.id).order("display_number ASC")
	  @inclusion_criteria_item = InclusionCriteriaItem.new
	  @exclusion_criteria = ExclusionCriteriaItem.where(:study_id => @study.id).order("display_number ASC")
	  @exclusion_criteria_item = ExclusionCriteriaItem.new
		render :layout => 'enrollment'		  
end
  
  # attributes
  # displays population attributes/characteristics data table
  def attributes
		@study = Study.find(params[:study_id])
		makeActive(@study)
		@project = Project.find(params[:project_id])
		@study_arms = Arm.where(:study_id => @study.id).all
		@baseline_characteristic_field = BaselineCharacteristicField.new
		@baseline_characteristic_data_point = BaselineCharacteristicDataPoint.new
		@baseline_characteristic_template_fields = BaselineCharacteristicField.where(:template_id => Study.get_template_id(@study.id)).all
		@baseline_characteristic_custom_fields = BaselineCharacteristicField.where(:study_id => @study.id).all
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
	@editing = params[:editing]
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
	template_id = Study.get_template_id(@study.id)
	# GATHER OUTCOMES
	@categorical_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Categorical").all
	@continuous_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Continuous").all
	# GATHER TIMEPOINTS
	@categorical_timepoints = Outcome.get_timepoints_for_outcomes_array(@categorical_outcomes);
	@continuous_timepoints = Outcome.get_timepoints_for_outcomes_array(@continuous_outcomes);
	# GATHER TEMPLATE COLUMNS
	@template_categorical_columns = OutcomeColumn.where(:template_id => template_id, :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeColumn.where(:template_id => template_id, :outcome_type => "Continuous").all
	
	@outcome_data_points = OutcomeResult.new
	
	# WHEN THE PAGE LOADS, FOOTNOTES ARRAYS ARE INITIALIZED AND NEED TO KNOW WHAT FIELDS
	# HAVE FOOTNOTES PREVIOUSLY DEFINED. SETTING THESE VARIABLES BELOW
	@cat_outcome_ids = @categorical_outcomes.collect{|catOut| catOut.id}
	@cont_outcome_ids = @continuous_outcomes.collect{|contOut| contOut.id}
	
	@study_arm_ids = @study_arms.collect{|arm| arm.id}
	
	@cat_cols = @template_categorical_columns.collect{|catCols| catCols.id}
	@cont_cols = @template_continuous_columns.collect{|contCols| contCols.id}
	
	categorical_fields = OutcomeResult.get_list_of_field_ids(@cat_outcome_ids, @study_arm_ids, @categorical_timepoints, @cat_cols)
	continuous_fields = OutcomeResult.get_list_of_field_ids(@cont_outcome_ids, @study_arm_ids, @continuous_timepoints, @cont_cols)
	
	# THESE ARRAYS ARE ULTIMATELY THE ONES USED BY OUR JAVASCRIPT FUNCTION TO INITIALIZE
	@cat_field_ids = categorical_fields.to_json
	@cont_field_ids = continuous_fields.to_json
	@cat_field_ids.gsub!(/[\"\[\]]/,"")
	@cont_field_ids.gsub!(/[\"\[\]]/,"")
		
	# gather any footnotes for the first selections
	@cat_footnotes = Footnote.where(:study_id=>session[:study_id], :page_name=>"results",:data_type=>"categorical").order("note_number ASC")
	@cont_footnotes = Footnote.where(:study_id=>session[:study_id],:page_name=>"results",:data_type=>"continuous").order("note_number ASC")

	@outcome_column = OutcomeColumn.new
	render :layout => 'outcomedata'	
	 end
  
	# outcomeanalysis
	# displays a table for (both?) categorical and continuous outcomes
	# enables data entry into that table (and saving)
  def outcomeanalysis
		@study = Study.find(params[:study_id])
		makeActive(@study)
		@model_name = "outcome_analysis" 
		@project = Project.find(params[:project_id])
		@study_arms = Arm.where(:study_id => params[:study_id]).all
		template_id = Study.get_template_id(@study.id)
		@outcomes = Outcome.find(:all, :conditions=>["study_id=?",session[:study_id]],:select=>["id","title","description"])
	  	
		@categorical_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Categorical").all
		@continuous_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Continuous").all
		@template_categorical_columns = OutcomeComparisonColumn.where(:template_id => template_id, :outcome_type => "Categorical").all
		@template_continuous_columns = OutcomeComparisonColumn.where(:template_id => template_id, :outcome_type => "Continuous").all
		@outcome_comparisons = OutcomeComparison.new

 		render :layout => 'outcomeanalysis'	 
 	end
  
    def adverseevents
		@study = Study.find(params[:study_id])
		@project = Project.find(params[:project_id])
		@adverse_events = AdverseEvent.where(:study_id => params[:study_id]).all
		@adverse_event = AdverseEvent.new
		@arms = Arm.find(:all, :conditions => ["study_id = ?", session[:study_id]], :order => "display_number ASC")
		template_id = Study.get_template_id(@study.id)
		@template_adverse_event_columns = AdverseEventColumn.where(:template_id => template_id).all
		@adverse_event_result = AdverseEventResult.new
  end
  
   def quality
	@study = Study.find(params[:study_id])
	session[:study_id] = @study.id
	@project = Project.find(params[:project_id])
	@quality_aspects = QualityAspect.where(:study_id => params[:study_id]).all	
	@quality_aspect = QualityAspect.new
	@exists = QualityRating.where(:study_id => session[:study_id]).first
	@quality_rating = @exists.nil? ? QualityRating.new : @exists
	@quality_dimension_field = QualityDimensionField.new
	@quality_dimension_data_point = QualityDimensionDataPoint.new
	@quality_dimension_custom_fields = QualityDimensionField.where(:study_id => params[:study_id]).all
	@study_template = StudyTemplate.where(:study_id => @study.id).first
	if !@study_template.nil?
	@quality_dimension_template_fields = QualityDimensionField.where(:template_id => @study_template.template_id).all
	end
	render :layout => 'quality'
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
		@arms = Arm.find(:all, :conditions => ["study_id = ?", session[:study_id]], :order => "display_number ASC")
		
  end
  
   def quality
	@study = Study.find(params[:study_id])
	session[:study_id] = @study.id
	@project = Project.find(params[:project_id])
	@quality_aspects = QualityAspect.where(:study_id => params[:study_id]).all	
	@quality_aspect = QualityAspect.new
	@exists = QualityRating.where(:study_id => session[:study_id]).first
	@quality_rating = @exists.nil? ? QualityRating.new : @exists
	@quality_dimension_field = QualityDimensionField.new
	@quality_dimension_data_point = QualityDimensionDataPoint.new
	@quality_dimension_custom_fields = QualityDimensionField.where(:study_id => params[:study_id]).all
	@study_template = StudyTemplate.where(:study_id => @study.id).first
	if !@study_template.nil?
	@quality_dimension_template_fields = QualityDimensionField.where(:template_id => @study_template.template_id).all
	end
	render :layout => 'quality'
	end
  
  # GET /studies/new
  # GET /studies/new.xml
  def new    
  	@study = Study.new
  	@study.project_id = params[:project_id]
  	session[:project_id] = params[:project_id] #added this line in case the user is coming from Home
		@study.save
		makeActive(@study)
	  @project_admin = Project.get_project_admin(params[:project_id])

		@study_template = StudyTemplate.new
		# if there is a template variable set in the new call
		Study.set_template_id_if_exists(params, @study)
		    	
		@primary_publication = Publication.create()
		@publication=Publication.new
	  @secondary_publications = []
			
		@questions = @study.get_question_choices(session[:project_id])
	    render :layout => 'studydesign'	
  end

  # POST /studies
  # POST /studies.xml
  def create
    @study = Study.new(params[:study])
	if !current_user.nil?
		@study.creator_id = current_user.id
	end
  	@study.project_id = params[:project_id]
		@project = Project.find(params[:project_id])
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
#							success_html = "<div class='success_message' style='vertical-align:text-top; display:inline'>Saved</div>"
#							page.replace_html 'key_question_validation_message', success_html
							#$('kq_save_status_div').visual_effect(:show)
							#page['kq_save_status_div'].visual_effect(:fade)
							page.call("show_save_indication","kq_save_status_div")
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
      format.html { 
    		unless params[:from] == "home"
	      	redirect_to(project_studies_path(session[:project_id])) 
	      else
	      	redirect_to root_url
	      end
    	}
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
