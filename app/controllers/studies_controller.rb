class StudiesController < ApplicationController
  # GET /studies
  # GET /studies.xml
  def index
    @studies = Study.all
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

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study }
    end
  end

    def design
	@study = Study.find(params[:study_id])
	session[:study_id] = @study.id
	@project = Project.find(params[:project_id])
	@arm = Arm.new
	@arms = Arm.find(:all, :conditions => {:study_id => @study.id})	
	#@key_question = KeyQuestion.new
  end
  
  def attributes
	@study = Study.find(params[:study_id])
	session[:study_id] = @study.id
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => @study.id})
	@population_characteristics = PopulationCharacteristic.find(:all, :conditions => {:study_id => @study.id}, :order => :category_title)
	 @population_characteristics.sort_by(&:category_title)
	@population_characteristic = PopulationCharacteristic.new
  end
  
    def outcomesetup
	@study = Study.find(params[:study_id])
	session[:study_id] = @study.id
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome = Outcome.new
	@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome_timepoints = OutcomeTimepoint.where(:outcome_id => @outcome.id).all	
	@outcome_timepoint = OutcomeTimepoint.new
	render :layout => 'outcomesetup'	
  end

    def outcomedata
	@study = Study.find(params[:study_id])
	session[:study_id] = @study.id
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome_result = OutcomeResult.new
  end
  
   def outcomeanalysis
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
		@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome_analyses = OutcomeAnalysis.where(:study_id => params[:study_id]).all
	@outcome_analysis = OutcomeAnalysis.new
  end

   def adverseevents
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@adverse_events = AdverseEvent.where(:study_id => params[:study_id]).all
	@adverse_event = AdverseEvent.new
  end
  
   def quality
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@quality_aspects = QualityAspect.where(:study_id => params[:study_id]).all	
	@quality_aspect = QualityAspect.new
	@quality_rating = QualityRating.new
  end
  
  # GET /studies/new
  # GET /studies/new.xml
  def new
    @study = Study.new
    @study.project_id = session[:project_id]
	  @study.save
	  makeActive(@study)
	  
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
	@study_key_questions_ids = StudiesKeyQuestion.where(:study_id => @study.id).all
	@study_key_questions = []
	@primary_publication = Publication.where(:study_id => @study.id, :is_primary => true).first
	if @primary_publication.nil?
		@primary_publication = Publication.new
	end
	for q in @study_key_questions_ids
		@study_key_questions << KeyQuestion.find(q.key_question_id)
	end
	#@publication = Publication.where(:study_id => @study.id, :is_primary => true).first
	#if @publication.nil?
		@publication = Publication.new
	#end
	@secondary_publications = Publication.where(:study_id => @study.id, :is_primary => false).all
    makeActive(@study)
    @questions = @study.get_question_choices(session[:project_id])
    @checked_ids = @study.get_addressed_ids

  end

  # POST /studies
  # POST /studies.xml
  def create
    @study = Study.new(params[:study])
  	@study.project_id = session[:project_id]
    makeActive(@study)
    
    questions = get_questions_params(params)
	@questions = @study.get_question_choices(session[:project_id])
    @checked_ids = @study.get_addressed_ids
    respond_to do |format|
      if @study.save
      	@study.assign_questions(questions)	  
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

    respond_to do |format|
      if @study.update_attributes(params[:study])
	  	questions = get_questions_params(params)
	@study.assign_questions(questions)	  
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
      format.html { redirect_to(studies_url) }
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

  
end
