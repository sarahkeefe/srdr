class FootnoteField < ActiveRecord::Base
	# remove footnote fields for the given study id
	def self.remove_entries(sid)
		footnotes = FootnoteField.where(:study_id=>sid)
		unless footnotes.empty?
			footnotes.each do |fnote|
				fnote.destroy
			end
		end
	end
end
