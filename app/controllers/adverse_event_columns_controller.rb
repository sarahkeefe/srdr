class AdverseEventColumnsController < ApplicationController
  # GET /adverse_event_columns
  # GET /adverse_event_columns.xml
  def index
    @adverse_event_columns = AdverseEventColumn.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adverse_event_columns }
    end
  end

  # GET /adverse_event_columns/1
  # GET /adverse_event_columns/1.xml
  def show
    @adverse_event_column = AdverseEventColumn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adverse_event_column }
    end
  end

  # GET /adverse_event_columns/new
  # GET /adverse_event_columns/new.xml
  def new
    @adverse_event_column = AdverseEventColumn.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adverse_event_column }
    end
  end

  # GET /adverse_event_columns/1/edit
  def edit
    @adverse_event_column = AdverseEventColumn.find(params[:id])
  end

 # POST /adverse_event_columns
  # POST /adverse_event_columns.xml
  def create
    @adverse_event_column = AdverseEventColumn.new(params[:adverse_event_column])

	if @adverse_event_column.save
		@template_adverse_event_columns = AdverseEventColumn.where(:template_id => @adverse_event_column.template_id).all
			respond_to do |format|
				format.js {
			      render :update do |page|
					    page.replace_html 'adverse_event_fields_table', :partial => 'adverse_event_columns/table', :locals => {:custom_template_id => @adverse_event_column.template_id}
					    page['new_adverse_event_column'].reset
						page.replace_html 'adverse_event_column_validation_message', ""
			      end
			    }
			end
		 else
				problem_html = "<div class='error_message'>The following errors prevented the column from being saved:<br/><ul>"
				for i in @adverse_event_column.errors
					problem_html += "<li>" + i.to_s + " " + @adverse_event_column.errors[i][0] + "</li>"
				end
				problem_html += "</ul>Please correct the form and press 'Save' again.</div><br/>"
						respond_to do |format|
				format.js {
					render :update do |page| 
						page.replace_html 'adverse_event_column_validation_message', problem_html
					end
				}
				format.xml  { render :xml => @adverse_event_column.errors, :status => :unprocessable_entity }
			end
 	 end
  end

  # PUT /adverse_event_columns/1
  # PUT /adverse_event_columns/1.xml
  def update
    @adverse_event_column = AdverseEventColumn.find(params[:id])

    respond_to do |format|
      if @adverse_event_column.update_attributes(params[:adverse_event_column])
        format.html { redirect_to(@adverse_event_column, :notice => 'Adverse event column was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adverse_event_column.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /adverse_event_columns/1
  # DELETE /adverse_event_columns/1.xml
  def destroy
    @adverse_event_column = AdverseEventColumn.find(params[:id])
    @adverse_event_column.destroy

    respond_to do |format|
      format.html { redirect_to(adverse_event_columns_url) }
      format.xml  { head :ok }
    end
  end
end
