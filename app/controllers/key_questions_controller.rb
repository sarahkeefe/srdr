class KeyQuestionsController < ApplicationController
  # GET /key_questions
  # GET /key_questions.xml
  def index
    @key_questions = KeyQuestion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @key_questions }
    end
  end

  # GET /key_questions/1
  # GET /key_questions/1.xml
  def show
    @key_question = KeyQuestion.find(params[:id])

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
      format.html # new.html.erb
      format.xml  { render :xml => @key_question }
    end
  end

  # GET /key_questions/1/edit
  def edit
    @key_question = KeyQuestion.find(params[:id])
  end

  # POST /key_questions
  # POST /key_questions.xml
  def create
    @key_question = KeyQuestion.new(params[:key_question])

    respond_to do |format|
      if @key_question.save
        format.html { redirect_to(@key_question, :notice => 'Key question was successfully created.') }
        format.xml  { render :xml => @key_question, :status => :created, :location => @key_question }
      else
        format.html { render :action => "new" }
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
        format.html { redirect_to(@key_question, :notice => 'Key question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @key_question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /key_questions/1
  # DELETE /key_questions/1.xml
  def destroy
    @key_question = KeyQuestion.find(params[:id])
    @key_question.destroy

    respond_to do |format|
      format.html { redirect_to(key_questions_url) }
      format.xml  { head :ok }
    end
  end
end
