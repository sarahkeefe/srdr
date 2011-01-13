class Footnote < ActiveRecord::Base
	
	# remove footnotes for the given study id
	def self.remove_entries(sid)
		footnotes = Footnote.where(:study_id=>sid)
		unless footnotes.empty?
			footnotes.each do |fnote|
				fnote.destroy
			end
		end
	end
	
	# return the number for a given footnote.
	def self.get_note_number(footnote_id)
		note = Footnote.find(footnote_id)
		return note.note_number
	end
end
