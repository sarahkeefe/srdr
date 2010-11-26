class OutcomeAnalysis < ActiveRecord::Base
	
	def self.remove_analyses(study_id, outcome_id, subgroup_id, timepoint_id)
		sql = ActiveRecord::Base.connection()
		sql.begin_db_transaction
		study_id = "'" + study_id.to_s + "'"
		sql.delete "DELETE FROM outcome_analyses WHERE study_id = #{study_id} AND outcome_id = #{outcome_id} AND subgroup_id = #{subgroup_id} AND timepoint_id = #{timepoint_id}"
		sql.commit_db_transaction
	end
end
