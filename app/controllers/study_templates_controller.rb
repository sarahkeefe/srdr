class StudyTemplatesController < ApplicationController
  # GET /study_templates
  # GET /study_templates.xml
  def index
    @study_templates = StudyTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @study_templates }
    end
  end

  # GET /study_templates/1
  # GET /study_templates/1.xml
  def show
    @study_template = StudyTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @study_template }
    end
  end

  # GET /study_templates/new
  # GET /study_templates/new.xml
  def new
    @study_template = StudyTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @study_template }
    end
  end

  # GET /study_templates/1/edit
  def edit
    @study_template = StudyTemplate.find(params[:id])
  end

  # POST /study_templates
  # POST /study_templates.xml
  def create
    @study_template = StudyTemplate.new(params[:study_template])
	study_id = @study_template.study_id
	@study_primary_pub = PrimaryPublication.new
	@study_primary_pub.study_id = study_id
	@study_primary_pub.title = "Untitled"
	@study_primary_pub.save
    respond_to do |format|
      if @study_template.save
		format.html { redirect_to(edit_project_study_path(params[:project_id], study_id), :notice => 'Template was successfully assigned.') }
        #format.xml  { render :xml => @study_template, :status => :created, :location => @study_template }
      else
        format.html { render :controller => "studies", :action => "new" }
        format.xml  { render :xml => @study_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /study_templates/1
  # PUT /study_templates/1.xml
  def update
    @study_template = StudyTemplate.find(params[:id])
	study_id = @study_template.study_id
    respond_to do |format|
      if @study_template.update_attributes(params[:template])
		format.html { redirect_to(edit_project_study_path(params[:project_id], study_id), :notice => 'Template was successfully assigned.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @study_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /study_templates/1
  # DELETE /study_templates/1.xml
  def destroy
    @study_template = StudyTemplate.find(params[:id])
    @study_template.destroy

    respond_to do |format|
      #format.html { redirect_to(study_templates_url) }
      #format.xml  { head :ok }
    end
  end
end
