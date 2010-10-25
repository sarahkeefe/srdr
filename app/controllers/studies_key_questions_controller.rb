class StudiesKeyQuestionsController < ApplicationController
  # GET /studies_key_questions
  # GET /studies_key_questions.xml
  def index
    @studies_key_questions = StudiesKeyQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @studies_key_questions }
    end
  end

  # GET /studies_key_questions/1
  # GET /studies_key_questions/1.xml
  def show
    @studies_key_question = StudiesKeyQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @studies_key_question }
    end
  end

  # GET /studies_key_questions/new
  # GET /studies_key_questions/new.xml
  def new
    @studies_key_question = StudiesKeyQuestion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @studies_key_question }
    end
  end

  # GET /studies_key_questions/1/edit
  def edit
    @studies_key_question = StudiesKeyQuestion.find(params[:id])
  end

  # POST /studies_key_questions
  # POST /studies_key_questions.xml
  def create
    @studies_key_question = StudiesKeyQuestion.new(params[:studies_key_question])

    respond_to do |format|
      if @studies_key_question.save
        format.html { redirect_to(@studies_key_question, :notice => 'Studies key question was successfully created.') }
        format.xml  { render :xml => @studies_key_question, :status => :created, :location => @studies_key_question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @studies_key_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /studies_key_questions/1
  # PUT /studies_key_questions/1.xml
  def update
    @studies_key_question = StudiesKeyQuestion.find(params[:id])

    respond_to do |format|
      if @studies_key_question.update_attributes(params[:studies_key_question])
        format.html { redirect_to(@studies_key_question, :notice => 'Studies key question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @studies_key_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /studies_key_questions/1
  # DELETE /studies_key_questions/1.xml
  def destroy
    @studies_key_question = StudiesKeyQuestion.find(params[:id])
    @studies_key_question.destroy

    respond_to do |format|
      format.html { redirect_to(studies_key_questions_url) }
      format.xml  { head :ok }
    end
  end
end
