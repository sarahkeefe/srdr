class OutcomeAnalysis < ActiveRecord::Base
	belongs_to :outcome
	
	def self.remove_analyses(study_id, outcome_id, subgroup_id, timepoint_id)
		sql = ActiveRecord::Base.connection()
		sql.begin_db_transaction
		study_id = "'" + study_id.to_s + "'"
		subgroup_id = "'"+subgroup_id+"'"
		timepoint_id="'"+timepoint_id+"'"
		sql.delete "DELETE FROM outcome_analyses WHERE study_id = #{study_id} AND outcome_id = #{outcome_id} AND subgroup_comp = #{subgroup_id} AND timepoint_comp = #{timepoint_id}"
		sql.commit_db_transaction
	end
	
	### THE FOLLOWING HAVE BEEN MOVED FROM THE STUDIES CONTROLLER ###
	######################################################################################
  # format the title of the analysis based on what has been selected.
  def self.get_analysis_title(outcome, subgroup, timepoint)
  	my_timepoint = timepoint.gsub("_"," ")
  	my_subgroup = subgroup.gsub("_"," ")
  	
  	comparison = Array.new
  	retVal = "Enter Analysis For: <strong>#{outcome}</strong><br/>"
  	being_compared="subgroup"
  	comparison_made = false
  	i = 0
  	[my_subgroup,my_timepoint].each do |title|
  	  if title=~/\svs\s/
  		  comparison_made = true
  		  if i > 0
  			   being_compared="title"
  		  end
  		  comparison = [being_compared, title]
  	  end
  	  i = i + 1
  	end
  	
  	if comparison_made
  		if comparison[0]=="title"
  			timepoints = comparison[1].split(/\svs\s/)
  			retVal += "Comparing <strong>" + timepoints[0].to_s + "</strong> to <strong>" + timepoints[1].to_s + 
  								"</strong> for the <strong>" + my_subgroup + "</strong> subgroup."
  	  elsif comparison[0] == "subgroup"
  	  	subgroups = comparison[1].split(/\svs\s/)
  			retVal += "Comparing <strong>" + subgroups[0].to_s + "</strong> and <strong>" + subgroups[1].to_s + 
  							 "</strong> subgroups at <strong>" + my_timepoint + "</strong>."
  	  end	
  	else
  		retVal += "<strong>"+ my_subgroup + "</strong> subgroup at <strong>" + my_timepoint + "</strong>."	
  	end
  	return retVal
  end
  
  
  # Given an array of subgroups in the outcome, construct an array of 
  # possible comparisons for the dropdown. Return this as an array of arrays
  # such as [["Option Display","Option Value"], ["Option Display 2","Option Value 2"]]
  def self.get_analysis_subgroup_comparisons(subgroups, selected_timepoint="Time_0")
  	retVal = Array.new
  	retVal << ['Total','Total']
  	subs = subgroups.collect{|sg| sg.title}
  	subs.each do |sub|
  	  retVal << [sub.gsub("_"," "), sub]	
  	end
  	unless selected_timepoint =~ /\_vs\_/
  		comparisons = Array.new
  		for i in 0..retVal.length-2
  			for j in i+1..retVal.length-1
  				title = retVal[j][0] + " vs " + retVal[i][0]
  				comparisons << [title, title.gsub(" ","_")]
	  		end
	  	end
	  	retVal = retVal + comparisons
	  end
  	return retVal
  end
  
  # Given an array of timepoints in the outcome, construct an array of 
  # possible comparisons for the dropdown. Return this as an array of arrays
  # such as [["Option Display","Option Value"], ["Option Display 2","Option Value 2"]]
  def self.get_analysis_timepoint_comparisons(timepoints, selected_subgroup="Total")
  	retVal = Array.new
  	retVal << ['Time 0','Time_0']
  	points = timepoints.collect{|tp| tp.number.to_s + "_" + tp.time_unit.to_s}
  	points.each do |point|
  	  retVal << [point.gsub("_"," "), point]	
  	end
  	unless selected_subgroup =~ /\_vs\_/
  		comparisons = Array.new
  		for i in 0..retVal.length-2
  			for j in i+1..retVal.length-1
  				title = retVal[j][0] + " vs " + retVal[i][0]
  				comparisons << [title, title.gsub(" ","_")]
	  		end
	  	end
	  	retVal = retVal + comparisons
	  end
	  
  	return retVal
  end
  
  # Return the values for selected subgroup and timepoint for outcome analysis. 
  def self.get_selected_analysis_sg_and_tp(subgroups,timepoints)
  	selected_subgroup = ""
  	selected_timepoint = ""
  	retVal=Array.new
  	unless subgroups.empty?
  		selected_subgroup = subgroups[0][1]
  		print "SETTING SELECTED SUBGROUP AS: " + selected_subgroup + "!!!!!!!!!!!!!\n\n"
  	end
  	unless timepoints.empty?
  		selected_timepoint = timepoints[0][1]
  		print "SETTING SELECTED TIMEPOINT AS: " + selected_timepoint + "!!!!!!!!!!!!!\n\n"
  	end
  	retVal = [selected_subgroup, selected_timepoint]
  	print "RETVAL IS: " + selected_subgroup.to_s + ", " + selected_timepoint.to_s + "--------------\n"
  	return retVal
  end
    ######################################################################################
	
end
