module ApplicationHelper
	
	def get_bread_crumbs(url,sep,user)
	begin
		print url + "\n\n\n\n"
		retVal = ""
		url.gsub!(/\?.*$/,"")
		unless url.split(/\//).length <= 3
		home_uri = "/projects/"
		elements = url.split('/')
		project_id = ""
		project_title = ""
		study_id = ""
		study_title = ""
		no_match = false
		is_end_of_trail = false
		
		# the string to return 
		retVal = "<a href='/'>Home</a> "
		
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
						retVal = retVal + create_crumb_link(study_uri, study_title, true)	
						#retVal = retVal + get_study_level_links(project_id, study_id,"|")
						if User.current_user_has_study_edit_privilege(project_id, user)
							retVal = retVal + get_study_level_jump_menu(project_id, study_id)
						end
					else
						 # fill this in for other types of urls
					end  
				when /^\w+/
					#uri = "/projects/#{project_id.to_s}/studies/#{study_id.to_s}/#{element.to_s}"
					#text = element.to_s.capitalize  
					#retVal = retVal + create_crumb_link(uri,text, is_end_of_trail)
					retVal.gsub!(/\>\s$/,"")
					
				else	
					# get rid of the trailing characters
					# is doing two chops more efficient?
					retVal.gsub!(/\>\s$/,"")
					no_match = true
			end
			retVal = retVal + " "
			i = i+1
		end
    end #ending the unless statement at the top
		return  retVal
		
		rescue
  		return "Error in breadcrumbs: " + elements[elements.length-1]
  	end
	end
	
	# Return a list of links when the user is already inside a study.
	# These should include things like Design, Baseline Characteristics,
	# Outcome Setup, Outcome Data Entry, Outcome Analysis, Adverse Events,
	# and Study Quality
	def get_study_level_links(pid, sid, sep)
		retVal = "<br/>&nbsp;&nbsp;Study Links: "
		base_url = "/projects/#{pid.to_s}/studies/#{sid.to_s}/"
		publication = "<a href='" + base_url + "edit'>Publications</a> " + sep + " "
		enrollment = "<a href='" + base_url + "enrollment'>Enrollment</a> "  + sep + " "		
		design = "<a href='" + base_url + "design'>Arms</a> "  + sep + " "
		characteristics = "<a href='" + base_url + "attributes'>Baseline Characteristics</a> " + sep + " "
		outcomes = "<a href='" + base_url + "outcomesetup'>Outcomes</a> " + sep + " "
		results = "<a href='" + base_url + "outcomedata'>Outcome Raw Data</a> " + sep + " "
		analysis = "<a href='" + base_url + "outcomeanalysis'>Outcome Comparisons</a> " + sep + " "
		adverse = "<a href='" + base_url + "adverseevents'>Adverse Events</a> " + sep + " " 
		quality = "<a href='" + base_url + "quality'>Study Quality</a> " + sep + " " 
		preview = "<a href='" + base_url + "'>Preview</a>"
		
		retVal = retVal + publication + enrollment + design + characteristics + outcomes + results + analysis + adverse + quality + preview
		return retVal
	end
	
	# An alternative way to display study-level links, this will allow users to jump to various 
	# sections in the study using a dropdown selector.
	def get_study_level_jump_menu(pid, sid)
		retVal = "<br/><div style='float:right;'><select class='jumpmenu'>"
		base_url = "/projects/#{pid.to_s}/studies/#{sid.to_s}/"
		default = "<option value='"+base_url+"edit'>Jump To Study Section...</option>"
		publication = "<option value='"+base_url+"edit'>Publications</option>"
		enrollment =  "<option value='"+base_url+"enrollment'>Enrollment</option>"
		arms = "<option value='"+base_url+"design'>Arms</option>"
		characteristics = "<option value='"+base_url+"attributes'>Baseline Characteristics</option>"
		outcomes = "<option value='"+base_url+"outcomesetup'>Outcome Setup</option>"
		results = "<option value='"+base_url+"outcomedata'>Outcome Raw Data</option>"
		analysis = "<option value='"+base_url+"outcomeanalysis'>Outcome Comparisons</option>"
		adverse = "<option value='"+base_url+"adverseevents'>Adverse Events</option>"
		quality = "<option value='"+base_url+"quality'>Study Quality</option>"
		preview = "<option value='"+base_url+"'>Preview/Summary</option>"
		retVal = retVal + default + publication + arms + enrollment + characteristics + outcomes + results + analysis + adverse + quality + preview
		retVal = retVal + "</select></div>"
		return retVal
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
  	
	# find out if any footnotes exist for this field, and if so, attach them to the 
	# value that is passed back to the form field
	def show_footnotes(val, field_name, info_hash)
		retVal = val.to_s
		notes_for_field = FootnoteField.where(:study_id=>info_hash[:study_id], :outcome_id=>info_hash[:outcome_id],
																					:subgroup_id=>info_hash[:subgroup_id],:timepoint_id=>info_hash[:timepoint_id],
																					:field_name=>field_name)
		#print "\n\n\n\n\nShowing footnotes and retVal starts off as being: #{retVal}\n\n\n"
  	unless notes_for_field.empty?
  		retVal += " ["
  		i = 0
  		notes_for_field.each do |note|   				
  			#fnote = Footnote.where(:study_id=>info_hash[:study_id],:outcome_id=>info_hash[:outcome_id],
  			#											 :subgroup_id=>info_hash[:subgroup_id],:timepoint_id=>info_hash[:timepoint_id],
  			#											 :note_number=>note.note_number);
  			
  			retVal = retVal + note.footnote_number.to_s
  			#print "\n\n\nNow I'm inside the loop and retVal is now equal to: #{retVal}\n\n\n"
  			unless(i >= (notes_for_field.length - 1))
  				retVal = retVal + ","
  			end
  			i += 1
  		end
  		retVal = retVal + "]"																	
  	end
  	#print "\n\n\nFinally, retVal equals: #{retVal}\n\n\n"
	  return retVal  	
  end		
end
