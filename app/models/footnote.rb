class Footnote < ActiveRecord::Base
	
	# remove footnotes for the combination of study id, 
	# outcome id, subgroup id and timepoint id
	def self.remove_entries(sid, ocid, sgid, tpid)
		footnotes = Footnote.where(:study_id=>sid,:outcome_id=>ocid,:subgroup_id=>sgid,:timepoint_id=>tpid)
		unless footnotes.empty?
			footnotes.each do |fnote|
				fnote.destroy
			end
		end
	end
end
