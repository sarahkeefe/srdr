class Project < ActiveRecord::Base
	cattr_reader :per_page
	@@per_page = 10
	
	has_many :studies, :dependent=>:destroy
	has_many :key_questions, :dependent=>:destroy
	has_many :arms, :through => :studies	
	accepts_nested_attributes_for :key_questions, :allow_destroy => true
	has_many :user_project_roles
	has_many :users, :through => :user_project_roles
	
	# info via http://stackoverflow.com/questions/408872/rails-has-many-through-find-by-extra-attributes-in-join-model
	has_many  :lead_users, :through => :user_project_roles, :class_name => "Project", :source => :project, :conditions => ['user_project_roles.role = ?',"lead"]
	has_many  :editor_users, :through => :user_project_roles, :class_name => "Project", :source => :project, :conditions => ['user_project_roles.role = ?',"editor"]
	
	def self.get_project_leads_string(p_id)
		@user_roles = UserProjectRole.where(:project_id =>p_id, :role => "lead").all
		@user_names = []
		for u in @user_roles
			@user = User.where(:id => u.user_id).first
			if !@user.nil?
				@user_names << @user.fname + " " + @user.lname
			end
		end
		return @user_names.to_sentence
	end
	
	def self.get_project_collabs_string(p_id)
		@user_roles = UserProjectRole.where(:project_id =>p_id, :role => "editor").all
		@user_names = []
		for u in @user_roles
			@user = User.find(u.user_id)
			@user_names << @user.fname + " " + @user.lname
		end
		return @user_names.to_sentence
	end
		
	def self.get_studies(project_id)
		return Study.where(:project_id => project_id).all
	end
	
	def self.get_num_studies(project)
		pid = project.id
		@studies = Study.where(:project_id => pid).all
		return @studies.length
	end
	
	def self.get_num_key_qs(project)
		pid = project.id
		@key_qs = KeyQuestion.where(:project_id => pid).all
		return @key_qs.length
	end
	
	def self.moveup(project_id, keyq)
		@proj = Project.find(project_id)
		keyq_id = keyq.id
		if keyq.question_number > 1
			keyq.question_number = keyq.question_number - 1
			@proj_kqs = KeyQuestion.where(:project_id => @proj.id)
			for kq in @proj_kqs
				if (kq.question_number == keyq.question_number) && (kq.id != keyq.id)
					kq.question_number = kq.question_number + 1
					kq.save
				end
			end
		end
		if keyq.save  
			format.js {
				render :update do |page|
					page.replace_html 'key_question_table', :partial => 'key_questions/table'
				end
			}
		end
	end
	# return the user object for the admin of the given project.
	# the resulting object only contains id and login information
	def self.get_project_admin(project_id)
		admin_id = Project.find(project_id,:select=>"creator_id")
		admin_id = admin_id.creator_id
		admin = User.find(admin_id, :select=>[:id,:login])
		return admin
	end
	
end
