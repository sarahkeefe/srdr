class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all
    respond_to do |format|
	  format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  def saveinfo
    respond_to do |format|
      format.html { redirect_to(project_studies_url) }
      format.xml  { head :ok }
    end
  end
  
  def studies
	@project = Project.find(params[:id])
	@studies = Study.where(:project_id => @project.id).all
	@key_question = KeyQuestion.new
  end
  
  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    makeActive(@project)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
	@project.save
	session[:project_id] = @project.id
	@key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
	@key_question = KeyQuestion.new
	    makeActive(@project)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
	session[:project_id] = @project.id
	    makeActive(@project)
	@key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
	@key_question = KeyQuestion.new	
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
end
  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
	clearSessionProjectInfo()
	
    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
    def clearSessionProjectInfo
  	session[:project_id] = nil
  	session[:project_title] = nil
  end
  def makeActive currentProject
    clearSessionProjectInfo()
  	session[:project_id] = currentProject.id
  	session[:project_title] = currentProject.title
  end
end
