class User < ActiveRecord::Base
acts_as_authentic
has_many :projects, :through => :user_project_roles

def self.username_exists(str)
print "TESTING-----------------------------------------------------------------------------------------"
	result_uname = User.where(:login => str).all
	if !result_uname.nil? && result_uname.length > 0
		return true
	else
		return false
	end
end

def self.email_exists(str)
	result_email = User.where(:email => str).all
	if !result_email.nil? && result_email.length > 0
		return true
	else
		return false	
	end
end

def self.user_has_roles(user, project)
	roles = UserProjectRole.where(:user_id => user.id, :project_id => project_id).all
	if !roles.nil? && roles.length > 0
		return true
	else
		return false
	end
end

def self.current_user_has_project_edit_privilege(project_id, user)
	if !user.nil?
		if user.user_type == "admin"
			return true
		else
			roles = UserProjectRole.where(:project_id => project_id, :user_id => user.id, :role => "lead").all
			if !roles.nil? && roles.length > 0
				return true
			else
				return false
			end
		end
	else
			return false
	end
end

def self.current_user_has_study_edit_privilege(project_id, user)
	if !user.nil?
		if user.user_type == "admin"
			return true
		else
			roles = UserProjectRole.where(:project_id => project_id, :user_id => user.id).all
			if !roles.nil? && roles.length > 0
				return true
			else
				return false
			end
		end
	else
			return false
	end
end

def self.current_user_has_new_project_privilege(user)
	if !user.nil?
		if user.user_type == "admin"
			return true
		elsif user.user_type == "member"
			return true
		else
			return false
		end
	else
			return false
	end
end


	def self.get_user_lead_roles (user)
		roles = UserProjectRole.where(:user_id => user.id, :role => "lead").all
		if !roles.nil? && roles.length > 0
			return roles
		else
			return nil
		end
	end
	
	def self.get_user_editor_roles (user)
		roles = UserProjectRole.where(:user_id => user.id, :role => "editor").all
		if !roles.nil? && roles.length > 0
			return roles
		else
			return nil
		end
	end	

	def self.get_users_for_project(project_id, current_user)
		users = UserProjectRole.where(:project_id => project_id).all
		new_list = []
		if !users.nil?
			for u in users
				if u.user_id != current_user.id
					new_list << u
				end
			end
		end
		return new_list
	end
	
end
