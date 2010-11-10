class KeyQuestionsController < ApplicationController
  # GET /key_questions
  # GET /key_questions.xml
  def index
    @key_questions = KeyQuestion.where(["project_id = ?", session[:project_id]])
    
    respond_to do |format|
    	  	
      format.html # index.html.erb
      format.xml  { render :xml => @key_questions }
    end
  end

  # GET /key_questions/1
  # GET /key_questions/1.xml
  def show
    @key_question = KeyQuestion.find(params[:id])
		@key_questions = KeyQuestion.where(:project_id => session[:project_id]).all
         
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @key_question }
    end
  end

  # GET /key_questions/new
  # GET /key_questions/new.xml
  def new
    @key_question = KeyQuestion.new
    respond_to do |format|
    	format.js{
    	  render :update do |page|
    	  	page.replace_html 'key_question_entry', :partial => 'key_questions/new_kq_form'
    	  end
  	  }
      format.html # new.html.erb
      format.xml  { render :xml => @key_question }
    end
  end

  # GET /key_questions/1/edit
  def edit
    @key_question = KeyQuestion.find(params[:id])
    respond_to do |format|
      format.js {
		  	render :update do |page|
					page.replace_html 'key_question_entry', :partial => 'key_questions/edit_kq_form'
				end
			}
	  end
  end
	
  # POST /key_questions
  # POST /key_questions.xml
  def create
    @key_question = KeyQuestion.new(params[:key_question])
    @key_question.project_id = session[:project_id]
    
    # insert the current question number for the project
    question_number = @key_question.get_question_number(session[:project_id])
    @key_question.question_number = question_number
    
    respond_to do |format|
      if @key_question.save
				@key_questions = KeyQuestion.where(:project_id => session[:project_id]).all
        format.js {
		  		render :update do |page|
						page.replace_html 'key_question_validation_message', ""				
						page.replace_html 'key_question_table', :partial => 'key_questions/table'
						new_row_name = "kq_row_" + question_number.to_s
						page['new_key_question'].reset
						page[new_row_name].visual_effect(:highlight, {:startcolor => "#00ee00",:endcolor => "#ffffff", 
																						 :restorecolor=>"#ffffff", :duration=>2})
						
				  end
				}
      else
		problem_html = "<div class='error_message'>The following errors prevented the question from being saved:<br/><ul>"
		for i in @key_question.errors
			problem_html += "<li>" + i.to_s + " " + @key_question.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
        format.html {render :update do |page| 
			page.replace_html 'key_question_validation_message', problem_html
			end
			}       
        format.xml  { render :xml => @key_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  		
  
  
  # PUT /key_questions/1
  # PUT /key_questions/1.xml
  def update
    @key_question = KeyQuestion.find(params[:id])

    respond_to do |format|
      if @key_question.update_attributes(params[:key_question])
        @key_questions = KeyQuestion.where(:project_id => session[:project_id]).all 
      	format.js {
		  		render :update do |page|
						page.replace_html 'key_question_validation_message', ""				
						page.replace_html 'key_question_table', :partial => 'key_questions/table'
						page.replace_html 'key_question_entry', :partial => 'key_questions/edit_kq_form'
					end
				}
      	format.html { redirect_to(project_key_question_path(session[:project_id],@key_question), :notice => 'Key question was successfully updated.') }
        format.xml  { head :ok }
      else
problem_html = "<div class='error_message'>The following errors prevented the question from being saved:<br/><ul>"
		for i in @key_question.errors
			problem_html += "<li>" + i.to_s + " " + @key_question.errors[i][0] + "</li>"
		end
		problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
        format.html {render :update do |page| 
			page.replace_html 'key_question_validation_message', problem_html
			end
			}       
        format.xml  { render :xml => @key_question.errors, :status => :unprocessable_entity }
      end
    end
  end
	def destroy
    @key_question = KeyQuestion.find(params[:id])
    @key_question.shift_question_numbers(session[:project_id])
    @key_question.destroy
    @key_question.remove_from_junction
    
    respond_to do |format|
      # update the list of key questions and create a new one to reset
    	# the entry form. This handles the event where the user is editing a record
    	# when they click on delete.
    	format.js {
				@key_questions = KeyQuestion.where(:project_id=>session[:project_id]).all
		  	render :update do |page|
					page.replace_html 'key_question_table', :partial => 'key_questions/table'	
					@key_question = KeyQuestion.new
					page.replace_html 'key_question_entry', :partial => 'key_questions/new_kq_form'					
		  	end
			}
    	format.html { redirect_to( project_key_questions_path(session[:project_id]) )}
      format.xml  { head :ok }
    end
  end
  # DELETE /key_questions/1
  # DELETE /key_questions/1.xml
 
end
