class TemplatesController < ApplicationController
  #respond_to :js, :html, :xml  
  
  # GET /templates
  # GET /templates.xml
  def index
    @templates = Template.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @templates }
    end
  end

 def baseline_characteristics
	@baseline_characteristic_field = BaselineCharacteristicField.new
	@baseline_characteristic_fields = BaselineCharacteristicField.where(:template_id => params[:template_id]).all
	@baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.new
	@baseline_characteristic_subcategory_fields = BaselineCharacteristicSubcategoryField.where(:baseline_characteristic_field_id => @baseline_characteristic_field.id).all
	render :layout => "templates"
 end
 
 def quality_dimensions
	@quality_dimension_field = QualityDimensionField.new
	@quality_dimension_fields = QualityDimensionField.where(:template_id => params[:template_id]).all
	render :layout => "templates"
 end
  
  # GET /templates/1
  # GET /templates/1.xml
  def show
    @template = Template.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @template }
    end
  end

  # GET /templates/new
  # GET /templates/new.xml
  def new
    @template = Template.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @template }
    end
  end

  # GET /templates/1/edit
  def edit
    @template = Template.find(params[:id])
  end

  # POST /templates
  # POST /templates.xml
  def create
    @template = Template.new(params[:template])

    respond_to do |format|
      if @template.save
		format.html { redirect_to("/templates/" + @template.id.to_s + "/baseline_characteristics", :notice => 'Template was successfully created.') }
        #format.xml  { render :xml => @template, :status => :created, :location => @template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /templates/1
  # PUT /templates/1.xml
  def update
    @template = Template.find(params[:id])

    respond_to do |format|
      if @template.update_attributes(params[:template])
		format.html { redirect_to("/templates/" + @template.id.to_s + "/baseline_characteristics", :notice => 'Template was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.xml
  def destroy
    @template = Template.find(params[:id])
    @template.destroy

    respond_to do |format|
      format.html { redirect_to(templates_url) }
      format.xml  { head :ok }
    end
  end
end
