class OutcomeResultsNotesController < ApplicationController
  # GET /outcome_results_notes
  # GET /outcome_results_notes.xml
  def index
    @outcome_results_notes = OutcomeResultsNote.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @outcome_results_notes }
    end
  end

  # GET /outcome_results_notes/1
  # GET /outcome_results_notes/1.xml
  def show
    @outcome_results_note = OutcomeResultsNote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @outcome_results_note }
    end
  end

  # GET /outcome_results_notes/new
  # GET /outcome_results_notes/new.xml
  def new
    @outcome_results_note = OutcomeResultsNote.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @outcome_results_note }
    end
  end

  # GET /outcome_results_notes/1/edit
  def edit
    @outcome_results_note = OutcomeResultsNote.find(params[:id])
  end

  # POST /outcome_results_notes
  # POST /outcome_results_notes.xml
  def create
    @outcome_results_note = OutcomeResultsNote.new(params[:outcome_results_note])

    respond_to do |format|
      if @outcome_results_note.save
        format.html { redirect_to(@outcome_results_note, :notice => 'Outcome results note was successfully created.') }
        format.xml  { render :xml => @outcome_results_note, :status => :created, :location => @outcome_results_note }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @outcome_results_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /outcome_results_notes/1
  # PUT /outcome_results_notes/1.xml
  def update
    @outcome_results_note = OutcomeResultsNote.find(params[:id])

    respond_to do |format|
      if @outcome_results_note.update_attributes(params[:outcome_results_note])
        format.html { redirect_to(@outcome_results_note, :notice => 'Outcome results note was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @outcome_results_note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /outcome_results_notes/1
  # DELETE /outcome_results_notes/1.xml
  def destroy
    @outcome_results_note = OutcomeResultsNote.find(params[:id])
    @outcome_results_note.destroy

    respond_to do |format|
      format.html { redirect_to(outcome_results_notes_url) }
      format.xml  { head :ok }
    end
  end
end
