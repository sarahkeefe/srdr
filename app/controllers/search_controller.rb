class SearchController < ApplicationController
  # GET /studies
  # GET /studies.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @studies }
    end
	end
	
	def results
		query_string = ""
		query_string = params[:user_input]
		
		@query = query_string.split()
		@proj_array = search_for_projects(@query) 
		@publications_array = search_for_primary_publications(@query)
		@study_info_array = get_study_info(@publications_array)
		
		respond_to do |format|
			format.html # sends them to results.html.erb
		end
	end
	
	def search_for_projects(query_array)
	  ret_arr = Array.new
		query_array.each do |q|
			q = "%"+q.to_s+"%"
			tmp_proj = Project.find(:all, :conditions=>["title LIKE ? OR description LIKE ?", q, q])
			for proj in tmp_proj
				ret_arr << proj
			end
		end
		ret_arr = remove_dups(ret_arr)
		return ret_arr
	end
	
	def search_for_primary_publications(query_array)
		ret_arr = Array.new
		query_array.each do |q|
			q = "%"+q.to_s+"%"
			tmp_pub = Publication.find(:all,:conditions=>["(title LIKE ? OR author LIKE ? or country LIKE ? OR ui LIKE ? or year LIKE ?) AND is_primary = ?",q,q,q,q,q,true])
			for pub in tmp_pub
				ret_arr << pub
			end
		end
		ret_arr = remove_dups(ret_arr)
	  return ret_arr
	end
	
	# return the project_id and study_type fields for the studies linked to the primary publications
	def get_study_info(publications)
	  ret_arr = Array.new
		publications.each do |pub|
		  if !pub.study_id.nil?
			tmp_study = Study.find(pub.study_id)
			ret_arr << [tmp_study.study_type, tmp_study.project_id]
		  end
		end
		return ret_arr
	end
	
	def remove_dups(projects)
		 projects.uniq #=> projects
		 return projects.uniq
	end
end
