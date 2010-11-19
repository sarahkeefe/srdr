module ApplicationHelper
	
	def get_bread_crumbs(url,sep)
	begin
		
		url.gsub!(/\?.*$/,"")
		home_uri = "/projects/"
		elements = url.split('/')
		project_id = ""
		project_title = ""
		study_id = ""
		study_title = ""
		no_match = false
		is_end_of_trail = false
		
		# the string to return 
		retVal = "<a href='\#'>Home</a> "
		
		# remove the http://www.srdr.com bit from the array
		elements = elements[3..elements.length-1]
		
		i = 0
		elements.each do |element|
			if i == elements.length - 1
				is_end_of_trail = true
			end
			
			retVal = retVal + '> '
		  case element
				when "projects"
			  	project_uri	= "/projects/"
					retVal = retVal + create_crumb_link(project_uri, "Projects", is_end_of_trail)
				 		
				when "studies"
					study_uri = "/projects/#{project_id.to_s}/studies"
					retVal = retVal + create_crumb_link(study_uri,"Studies", is_end_of_trail)
			
				when "search"
					retVal = retVal + create_crumb_link('/search/','Search',true)
					retVal.gsub!(/\>$/,"")
				
				when /^\d+/
			  	previous = elements[i-1]
					if previous == "projects"
						project_id = element.to_i
						project_title = Project.find(project_id,:select=>"title")
						unless project_title.nil?
							project_title = project_title.title
						else
							project_title = "New Project"
						end
						project_uri = "/projects/#{project_id.to_s}"
						retVal = retVal + create_crumb_link(project_uri, project_title, is_end_of_trail)
											
					elsif previous == "studies"
						study_id = element.to_i
						study_title = Publication.find(:first,:conditions=>["study_id=? AND is_primary=?",study_id.to_i,"t"],:select=>"title")
						unless study_title.nil?
							study_title = study_title.title
						else
							study_title="New Study"
						end
						study_uri = "/projects/#{project_id.to_s}/studies/#{study_id.to_s}"
						retVal = retVal + create_crumb_link(study_uri, study_title, is_end_of_trail)	
					else
						 # fill this in for other types of urls
					end  
				when /^\w+/
					uri = "/projects/#{project_id.to_s}/studies/#{study_id.to_s}/#{element.to_s}"
					text = element.to_s.capitalize  
					retVal = retVal + create_crumb_link(uri,text, is_end_of_trail)
					
				else	
					# get rid of the trailing characters
					# is doing two chops more efficient?
					retVal.gsub!(/\>\s$/,"")
					no_match = true
			end
			retVal = retVal + " "
			i = i+1
		end
		return  retVal
		
		rescue
  		return "Error in breadcrumbs: " + elements[elements.length-1]
  	end
	end
	
	def create_crumb_link(uri,text,end_of_trail)
		link = ""
		if end_of_trail
			link = "<span style='font-weight: bold;'>#{text.to_s}</span>"
		else
			link = '<a href='+uri.to_s+'>'+shrink_text(text.to_s)+'</a>'
		end
		return link
	end
	
	def shrink_text(text, num_words=5)
		text = text.split[0..(num_words-1)].join(" ") + (text.split.size > num_words ? "..." : "")
		return text
	end
end
