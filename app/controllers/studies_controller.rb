class StudiesController < ApplicationController
  # GET /studies
  # GET /studies.xml
  def index
    @studies = Study.all

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
	@project = Project.find(params[:project_id])
	@arm = Arm.new
	#@key_question = KeyQuestion.new
  end
  
  def attributes
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@atts = PopulationCharacteristic.find(:all, :conditions => {:study_id => params[:study_id]})
	@population_characteristic = PopulationCharacteristic.new
  end
  
    def outcomesetup
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome = Outcome.new
	@outcome_timepoint = OutcomeTimepoint.new
  end

    def outcomedata
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome_result = OutcomeResult.new
  end
  
   def outcomeanalysis
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	#@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	@outcome_analysis = OutcomeAnalysis.new
  end

   def adverseevents
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	#@outcomes = Outcome.find(:all, :conditions => {:study_id => params[:study_id]})
	@adverse_event = AdverseEvent.new
  end
  
     def quality
	@study = Study.find(params[:study_id])
	@project = Project.find(params[:project_id])
	@study_arms = Arm.find(:all, :conditions => {:study_id => params[:study_id]})
	@quality_aspect = QualityAspect.new
	@quality_rating = QualityRating.new
  end
  
  # GET /studies/new
  # GET /studies/new.xml
  def new
    @study = Study.new
	@study.save
	@study.project_id = params[:project_id]
	@arm = Arm.new
	@arm.study_id = @study.id
	@publication = Publication.new
	#comment
	@study_key_questions = KeyQuestion.find(:all, :conditions => {:project_id => params[:project_id]})
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study }
    end
  end

  # GET /studies/1/edit
  def edit
    @study = Study.find(params[:id])
  end

  # POST /studies
  # POST /studies.xml
  def create
    @study = Study.new(params[:study])

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

    respond_to do |format|
      if @study.update_attributes(params[:study])
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
end
