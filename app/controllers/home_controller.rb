class HomeController < ApplicationController

  before_filter :require_user

  def index
	@user_session = UserSession.new
  end

  def create
  end
  
end
