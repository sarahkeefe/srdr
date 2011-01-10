class HomeController < ApplicationController

  #before_filter :require_user

  def index
  	session.delete :project_id
	  @user_session = UserSession.new
  end

  def create
  end
  
end
