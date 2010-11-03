class StudiesController < ApplicationController
  # GET /studies
  # GET /studies.xml
  def index
    @studies = Study.where(:project_id => params[:project_id])
	  #@study_titles = Study.get_ui_title_author_year(@studies)
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
	  makeActive(@study)
		@arm = Arm.new
	  @arms = Arm.find(:all, :conditions => {:study_id => @study.id})	
	end
  
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
  end
  
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

  def outcomedata
	@study = Study.find(params[:study_id])
	makeActive(@study)
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
	  	  	  	page['status_box'].visual_effect(:highlight,{:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
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

  
end
