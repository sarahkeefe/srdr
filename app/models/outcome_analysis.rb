class OutcomeAnalysis < ActiveRecord::Base
	
	def self.remove_analyses(study_id)
		sql = ActiveRecord::Base.connection()
		sql.begin_db_transaction
		study_id = "'" + study_id.to_s + "'"
		sql.delete "DELETE FROM outcome_analyses WHERE outcome_analyses.study_id = #{study_id}"
		sql.commit_db_transaction
	end
end
