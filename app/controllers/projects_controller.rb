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
  
  def moveup
@keyquestion = KeyQuestion.find(params[:kqid])
    respond_to do |format|
		if @key_question.save  
			format.js {
				render :update do |page|
					page.replace_html 'key_question_table', :partial => 'key_questions/table'
				end
			}
		end
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
	@key_questions = KeyQuestion.where(:project_id => @project.id)
	@studies = Study.where(:project_id => @project.id)
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
	proj_id = @project.id	
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
	proj_id = @project.id
	    makeActive(@project)
	@key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
	@key_question = KeyQuestion.new	
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
	@key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
	@key_question = KeyQuestion.new	
    respond_to do |format|
      if @project.save
        #format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.html {render :update do |page| 
						page.replace_html 'validation_message', "<div class='success_message'>Saved successfully!</div><br/>"
					page.visual_effect(:appear, 'validation_message')	
					end
					}		
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @project.errors
			problem_html += "<li>" + i.to_s + " " + @project.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
        format.html {render :update do |page| 
			page.replace_html 'validation_message', problem_html
			end
			}       
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
	@key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
	@key_question = KeyQuestion.new	
    respond_to do |format|
      if @project.update_attributes(params[:project])
        #format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.html {render :update do |page| 
						page.replace_html 'validation_message', "<div class='success_message'>Saved successfully!</div><br/>"
					page.visual_effect(:appear, 'validation_message')	
					end
					}
		format.xml  { head :ok }
      else
        #format.html { render :action => "edit" }
		problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
		for i in @project.errors
			problem_html += "<li>" + i.to_s + " " + @project.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
        format.html {render :update do |page| 
			page.replace_html 'validation_message', problem_html
			end
			}        
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
