class ProjectsController < ApplicationController
	before_filter :require_user, :except => :index
	before_filter :require_user, :except => :show
	
  # GET /projects
  # GET /projects.xml
  def index
    #@pages, @projects = paginate_collection Project.all, :page => @params[:page]
  	#@projects = Project.all
  	@projects = Project.paginate(:page=>params[:page], :order=>'created_at DESC')
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
  
  def manage
	@project = Project.find(params[:project_id])
	@project_users = User.get_users_for_project(@project.id, current_user)
	@user_project_roles = UserProjectRole.new
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
		makeActive(@project)
		@studies = Study.where(:project_id => @project.id).all
		@key_question = KeyQuestion.new
  end
  
  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])
    makeActive(@project)
    # get the key questions and format them for display in the table
    # see format_for_display in KeyQuestion model
    @key_questions = KeyQuestion.find(:all, :conditions=>["project_id=?",@project.id], :order=>"question_number ASC")
      
	  @studies = Study.where(:project_id => @project.id)
	  @kq_formatted_strings = Study.get_addressed_question_numbers_for_studies(@studies)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.create
		
		makeActive(@project)
		proj_id = @project.id	
		@key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
		@key_question = KeyQuestion.new
	  		if !current_user.nil?
			@user_role = UserProjectRole.new
			@user_role.user_id = current_user.id
			@user_role.project_id = @project.id
			@user_role.role = "lead"
			@user_role.save
		end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
	  makeActive(@project)
	  proj_id = @project.id
	  @key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id}, :order => "question_number ASC")
	  @key_question = KeyQuestion.new	
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
		if !current_user.nil?
			@project.creator_id = current_user.id
		end
		@key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
		@key_question = KeyQuestion.new	
    respond_to do |format|
      if @project.save
		# Save user role for this project

        format.html {render :update do |page| 
						page.replace_html 'validation_message', "<div class='success_message' style='display:none;'>Saved successfully!</div><br/>"
						#page.call("show_save_indication","success_message");
					  #page.visual_effect(:appear, 'validation_message')	
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
    unless current_user.nil?
			@project.creator_id = current_user.id
	  end
		makeActive(@project)
    @key_questions = KeyQuestion.find(:all, :conditions => {:project_id => @project.id})
		@key_question = KeyQuestion.new	
    respond_to do |format|
      if @project.update_attributes(params[:project])
        #format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.html {
          render :update do |page| 
	        	page.replace_html 'validation_message', "<div class='success_message' id='success_div' style='display:none;'>Saved successfully!</div><br/>"
						page.call("show_save_indication","success_div");
						page.call("show_save_indication","project_save_status_div");
						#page.visual_effect(:appear, 'validation_message')	
				  end
				}
				format.xml  { head :ok }
      else
				problem_html = "<div class='error_message'>The following errors prevented the form from being submitted:<br/><ul>"
				for i in @project.errors
					problem_html += "<li>" + i.to_s + " " + @project.errors[i][0] + "</li>"
				end
				problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
		    
				format.html {
					render :update do |page| 
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
    UserProjectRole.remove_roles_for_project(@project.id)
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
