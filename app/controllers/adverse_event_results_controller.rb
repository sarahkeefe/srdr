class AdverseEventResultsController < ApplicationController
  # GET /adverse_event_results
  # GET /adverse_event_results.xml
  def index
    @adverse_event_results = AdverseEventResult.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @adverse_event_results }
    end
  end

  # GET /adverse_event_results/1
  # GET /adverse_event_results/1.xml
  def show
    @adverse_event_result = AdverseEventResult.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @adverse_event_result }
    end
  end

  # GET /adverse_event_results/new
  # GET /adverse_event_results/new.xml
  def new
    @adverse_event_result = AdverseEventResult.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @adverse_event_result }
    end
  end

  # GET /adverse_event_results/1/edit
  def edit
    @adverse_event_result = AdverseEventResult.find(params[:id])
  end

  # POST /adverse_event_results
  # POST /adverse_event_results.xml
  def create
    AdverseEventResult.save_data_points(params, params[:study_id])

    respond_to do |format|
        format.js { 
			render :update do |page|		
				saved_html = "<div class='success_message'>Saved Successfully!</div><br/>"
				page.replace_html 'adverse_event_validation_message', saved_html		
			end
		}
    end
  end

  # PUT /adverse_event_results/1
  # PUT /adverse_event_results/1.xml
  def update
    AdverseEventResult.save_data_points(params, params[:study_id])

    respond_to do |format|
        format.js { 
			render :update do |page|		
				saved_html = "<div class='success_message' id='adv_ev_save_status_div'>Saved Successfully!</div><br/>"
				page.replace_html 'adverse_event_validation_message', saved_html
				page.call 'hide', 'adverse_event_validation_message'
			end
		}
    end
  end

  # DELETE /adverse_event_results/1
  # DELETE /adverse_event_results/1.xml
  def destroy
    @adverse_event_result = AdverseEventResult.find(params[:id])
    @adverse_event_result.destroy

    respond_to do |format|
      format.html { redirect_to(adverse_event_results_url) }
      format.xml  { head :ok }
    end
  end
end
