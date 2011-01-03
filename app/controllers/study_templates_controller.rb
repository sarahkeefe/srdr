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

    respond_to do |format|
      if @study_template.save
        format.js { 
			render :update do |page|
				page.replace_html 'template_save_validation_message', "Template assigned successfully."
			end
		}
      else
        format.js { 
			render :update do |page|
				page.replace_html 'template_save_validation_message', "There was a problem assigning the template."
			end
		}
      end
    end
  end

  # PUT /study_templates/1
  # PUT /study_templates/1.xml
  def update
    @study_template = StudyTemplate.find(params[:id])

    respond_to do |format|
      if @study_template.update_attributes(params[:study_template])
        #format.html { redirect_to(@study_template, :notice => 'Study template was successfully updated.') }
        #format.xml  { head :ok }
      else
        #format.html { render :action => "edit" }
        #format.xml  { render :xml => @study_template.errors, :status => :unprocessable_entity }
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
