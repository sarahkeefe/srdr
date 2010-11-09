class OutcomeAnalysis < ActiveRecord::Base
	
	def self.remove_analyses(study_id,type)
		sql = ActiveRecord::Base.connection()
		sql.begin_db_transaction
		type = "'" + type.to_s + "'"
		study_id = "'" + study_id.to_s + "'"
		sql.delete "DELETE FROM outcome_analyses WHERE outcome_analyses.study_id = #{study_id} AND categorical_or_continuous = #{type}"
		sql.commit_db_transaction
	end
end
