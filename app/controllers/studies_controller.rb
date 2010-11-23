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
	  @categorical_analyses = OutcomeAnalysis.where(:categorical_or_continuous => "Categorical", :study_id => @study.id).all
	  @categorical_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Categorical").all
	  @continuous_analyses = OutcomeAnalysis.where(:categorical_or_continuous => "Continuous", :study_id => @study.id).all
	  @continuous_outcomes = Outcome.where(:study_id => @study.id, :outcome_type => "Continuous").all	  
	  
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
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome_result = OutcomeResult.new
	@selected_outcome = Outcome.where(:study_id => params[:study_id]).first
		render :layout => 'outcomesetup'	
	 end
  
	# outcomeanalysis
	# displays a table for (both?) categorical and continuous outcomes
	# enables data entry into that table (and saving)
   def outcomeanalysis
	   @new_categorical_analysis = nil
	   @new_continuous_analysis = nil
	   @categorical_analyses = []
	   @continuous_analyses = []
	   
		 @study_arms = Arm.find(:all, :conditions=>["study_id=?",session[:study_id]], :select=>["id","title"])
	   
		 @continuous_outcomes = Outcome.find(:all, :conditions=>["study_id=? AND outcome_type=?",session[:study_id],"Continuous"],:select=>["id","title","description"])
		 
	   @categorical_outcomes = Outcome.find(:all, :conditions=>["study_id=? AND outcome_type=?",session[:study_id],"Categorical"],:select=>["id","title","description"])	   																		 														 
    
     unless @categorical_outcomes.empty?
		 	@new_categorical_analysis = OutcomeAnalysis.new
		  @categorical_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND categorical_or_continuous=?",session[:study_id], "Categorical"])	   				
	 	 end
	 	 
	 	 unless @continuous_outcomes.empty?
	   	@new_continuous_analysis = OutcomeAnalysis.new
      @continuous_analyses = OutcomeAnalysis.find(:all, :conditions=>["study_id=? AND categorical_or_continuous=?",session[:study_id], "Continuous"])
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
		page.replace_html 'outcome_results_table', :partial => 'outcome_results/table'
	end
	}
	end
  end
end
