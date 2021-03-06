class CustomTemplatesController < ApplicationController
  #respond_to :js, :html, :xml  
  
  # GET /templates
  # GET /templates.xml
  def index
    @templates = CustomTemplate.all

  	render :layout => "templates"	
  end

  def key_questions
  	render :layout => "templates"
  end
  
  def publication_info
  	render :layout => "templates"
  end
  
  def arms
  	render :layout => "templates"
  end
  
  def outcome_setup
  	render :layout => "templates"
  end
  
  def adverse_events
	@template_adverse_event_columns = AdverseEventColumn.where(:template_id => params[:custom_template_id]).all  
  	render :layout => "templates"
  end
  
  
 def design_details
	@design_detail_field = DesignDetailField.new
	@design_detail_fields = DesignDetailField.where(:template_id => params[:custom_template_id]).all
	@design_detail_subcategory_field = DesignDetailSubcategoryField.new
	@design_detail_subcategory_fields = DesignDetailSubcategoryField.where(:design_detail_field_id => @design_detail_field.id).all
	render :layout => "templates"
 end  
  
 def baseline_characteristics
	@baseline_characteristic_field = BaselineCharacteristicField.new
	@baseline_characteristic_fields = BaselineCharacteristicField.where(:template_id => params[:custom_template_id]).all
	@baseline_characteristic_subcategory_field = BaselineCharacteristicSubcategoryField.new
	@baseline_characteristic_subcategory_fields = BaselineCharacteristicSubcategoryField.where(:baseline_characteristic_field_id => @baseline_characteristic_field.id).all
	render :layout => "templates"
 end
 
 def quality_dimensions
	@quality_dimension_field = QualityDimensionField.new
	@quality_dimension_fields = QualityDimensionField.where(:template_id => params[:custom_template_id]).all
	render :layout => "templates"
 end
 
 def outcome_datatable
	@template_categorical_columns = OutcomeColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Continuous").all
	render :layout => "templates"
 end

 def outcome_comparisons
	@template_categorical_columns = OutcomeComparisonColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeComparisonColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Continuous").all
  	render :layout => "templates"	
 end

 
  # GET /templates/1
  # GET /templates/1.xml
  def show
    @template = CustomTemplate.find(params[:id])
	@baseline_characteristic_fields = BaselineCharacteristicField.where(:template_id => @template.id).all
	@quality_dimension_fields = QualityDimensionField.where(:template_id => @template.id).all
	@template_categorical_columns = OutcomeColumn.where(:template_id => @template.id, :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeColumn.where(:template_id => @template.id, :outcome_type => "Continuous").all		
  	render :layout => "templates"	
  end

  # GET /templates/new
  # GET /templates/new.xml
  def new
    @template = CustomTemplate.new

  	render :layout => "templates"	
  end

  # GET /templates/1/edit
  def edit
    @template = CustomTemplate.find(params[:id])
	
	  	render :layout => "templates"	
  end

  # POST /templates
  # POST /templates.xml
  def create
    @template = CustomTemplate.new(params[:custom_template])
	
    respond_to do |format|
      if @template.save
	  	CustomTemplate.create_default_outcome_columns(@template.id)
		CustomTemplate.create_default_outcome_comparison_columns(@template.id)
		CustomTemplate.create_default_design_details(@template.id)
		CustomTemplate.create_default_adverse_event_columns(@template.id)
		format.html { redirect_to("/custom_templates/" + @template.id.to_s + "/edit", :notice => 'CustomTemplate was successfully created.') }
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
    @template = CustomTemplate.find(params[:id])

    respond_to do |format|
      if @template.update_attributes(params[:template])
		format.html { redirect_to("/custom_templates/" + @template.id.to_s + "/edit", :notice => 'CustomTemplate was successfully updated.') }
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
    @template = CustomTemplate.find(params[:id])
	  @template_studies = StudyTemplate.where(:template_id => @template.id).all
	  for ts in @template_studies
	  	ts.destroy
	  end
		@template_columns = OutcomeColumn.where(:template_id => @template.id).all
		for tc in @template_columns
			tc.destroy
		end
    @template.destroy

    respond_to do |format|
      format.html { 
				unless params[:from] == 'home'	
      		render :update do |page|
						page.reload
					end
				else
					redirect_to root_url
				end
	  	}
      format.xml  { head :ok }
    end
  end
  
  
 def delete_column
	@column = OutcomeColumn.where(:id => params[:id]).first
	@column.destroy
	@template_categorical_columns = OutcomeColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Continuous").all		
   respond_to do |format|
		format.js {
		      render :update do |page|
					page.replace_html 'outcome_data_fields_table', :partial => 'outcome_columns/table'
		  		end
				}
		end
 end
 
  def delete_comparison_column
	@column = OutcomeComparisonColumn.where(:id => params[:id]).first
	@column.destroy
	@template_categorical_columns = OutcomeComparisonColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Categorical").all
	@template_continuous_columns = OutcomeComparisonColumn.where(:template_id => params[:custom_template_id], :outcome_type => "Continuous").all		
   respond_to do |format|
		format.js {
		      render :update do |page|
					page.replace_html 'outcome_comparisons_table', :partial => 'outcome_comparison_columns/table'
		  		end
				}
		end
 end
 
 def delete_adverse_event_column
	@column = AdverseEventColumn.where(:id => params[:id]).first
	@column.destroy
	@template_adverse_event_columns = AdverseEventColumn.where(:template_id => params[:custom_template_id]).all
	
   respond_to do |format|
		format.js {
		      render :update do |page|
					page.replace_html 'adverse_event_fields_table', :partial => 'adverse_event_columns/table'
		  		end
				}
		end
 end 
 
end
