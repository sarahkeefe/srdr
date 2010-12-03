class OutcomeResultsNote < ActiveRecord::Base

	def self.get_note_object(outcome_id, timepoint_id, subgroup_id)
		@outcome_note = self.where(:outcome_id => outcome_id, :timepoint_id => timepoint_id, :subgroup_id => subgroup_id).first
		if @outcome_note.nil?
			return self.new
		else return @outcome_note
		end
	end
end
