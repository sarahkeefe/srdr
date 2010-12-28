class UserProjectRole < ActiveRecord::Base
	belongs_to :project
	belongs_to :user
	
	def get_full_role
		if role == "lead"
			return "Project Lead"
		elsif role == "editor"
			return "editor"
		end
	end
	
	def self.set_up_role_hash(user_project_role_list)
		the_hash = Hash.new
		if !user_project_role_list.nil?
			for i in user_project_role_list
				the_hash["editor_" + i.user_id.to_s] = i.role + "_" + i.user_id.to_s
				the_hash["lead_" + i.user_id.to_s] = i.role + "_" + i.user_id.to_s
				the_hash["delete_" + i.user_id.to_s] = i.role + "_" + i.user_id.to_s
			end
		end
		return the_hash
	end
end
