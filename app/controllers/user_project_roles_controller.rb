class UserProjectRolesController < ApplicationController
before_filter :require_user
 
 
 def add_new_user
	if !params["new_user"].nil?
		new_user = params["new_user"]
		uname_exists = User.username_exists(new_user)
		email_exists = User.email_exists(new_user)
		if !uname_exists && !email_exists
			#redirect - no username or email exists
			the_notice = "A user with that information does not exist. Please contact that person and have them register with SRDR before adding them to this project."
		elsif uname_exists
			print "uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu"
			@user = User.where(:login => new_user).first
			@upr = UserProjectRole.new
			@upr.user_id = @user.id
			@upr.project_id = params[:project_id]
			@upr.role = params[:new_role]
			@upr.save
			the_notice = "User added successfully."		
		elsif email_exists
			print "eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee"
			@user = User.where(:email => new_user).first
			@upr = UserProjectRole.new
			@upr.user_id = @user.id
			@upr.project_id = params[:project_id]
			@upr.role = params[:new_role]
			@upr.save
			the_notice = "User added successfully."
		end
	end
	
	respond_to do |format|
		format.html { redirect_to '/projects/' + params[:project_id].to_s + '/manage', :notice => the_notice }
		format.xml  { head :ok }
	end
	
 end
 
  def saveinfo
  project_id = params["project_id"]
  for i in params
	param_string_0 = i[0].split("_")
	if param_string_0[0] == "roles"
		num = param_string_0[1].to_i
		# num is user_id
		# project_id is project id
		@role = UserProjectRole.where(:user_id => num, :project_id => project_id).first
		if !@role.nil?
			if @role.role != i[1] # if current role does not equal submitted/requested role
				# destroy all existing roles
				@roles = UserProjectRole.where(:user_id => num, :project_id => project_id).all
				@roles.each do|ro|
					ro.destroy
				end
			end			
		end #if existing role is not nil
		if i[1] != "delete" # not equals delete
			@new_role = UserProjectRole.new
			@new_role.user_id = num
			@new_role.project_id = project_id
			@new_role.role = i[1]
			@new_role.save
		end

	end	
  end
	the_notice = "Changes saved."
	respond_to do |format|
		format.html { redirect_to '/projects/' + params[:project_id].to_s + '/manage', :notice => the_notice }
		format.xml  { head :ok }
	end
  end

 # GET /user_project_roles
  # GET /user_project_roles.xml
  def index
    @user_project_roles = UserProjectRole.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user_project_roles }
    end
  end

  # GET /user_project_roles/1
  # GET /user_project_roles/1.xml
  def show
    @user_project_role = UserProjectRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user_project_role }
    end
  end

  # GET /user_project_roles/new
  # GET /user_project_roles/new.xml
  def new
    @user_project_role = UserProjectRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user_project_role }
    end
  end

  # GET /user_project_roles/1/edit
  def edit
    @user_project_role = UserProjectRole.find(params[:id])
  end

  # POST /user_project_roles
  # POST /user_project_roles.xml
  def create
    @user_project_role = UserProjectRole.new(params[:user_project_role])

    respond_to do |format|
      if @user_project_role.save
        format.html { redirect_to(@user_project_role, :notice => 'User project role was successfully created.') }
        format.xml  { render :xml => @user_project_role, :status => :created, :location => @user_project_role }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user_project_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user_project_roles/1
  # PUT /user_project_roles/1.xml
  def update
    @user_project_role = UserProjectRole.find(params[:id])

    respond_to do |format|
      if @user_project_role.update_attributes(params[:user_project_role])
        format.html { redirect_to(@user_project_role, :notice => 'User project role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user_project_role.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user_project_roles/1
  # DELETE /user_project_roles/1.xml
  def destroy
    @user_project_role = UserProjectRole.find(params[:id])
    @user_project_role.destroy

    respond_to do |format|
      format.html { redirect_to(user_project_roles_url) }
      format.xml  { head :ok }
    end
  end
end
