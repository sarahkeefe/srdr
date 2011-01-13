class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  private
    def current_user_session
      logger.debug "ApplicationController::current_user_session"
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      logger.debug "ApplicationController::current_user"
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end

    def require_user
      logger.debug "ApplicationController::require_user"
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      logger.debug "ApplicationController::require_no_user"
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to ""
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(default)
      #session[:return_to] = nil
    end
    
  # gather footnote information from the parameter and return an an array of footnote hashes
  def get_footnotes_from_params(form_params)
  	#print "\n\n\n\n Getting Footnotes...."
  	footnotes = Array.new
  	form_params.keys.each do |key|
  		if key =~ /_footnote_/
  			
  			# the key being split would be something like:
  			# categorical_footnote_1  or continuous_footnote_1
  			note_parts = key.split("_");
  			
  			tmp_note = {:note_number=>note_parts[2],
  									:study_id=>session[:study_id],
  									:note_text=>form_params[key],
  									:page_name=>"results",
  									:data_type => note_parts[0]}							 
  			footnotes << tmp_note
  		end
  	end
  	#print "Done.\n\n\n\n"
  	return footnotes
	end
end
