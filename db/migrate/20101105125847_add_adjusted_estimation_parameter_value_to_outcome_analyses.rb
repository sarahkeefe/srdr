class AddAdjustedEstimationParameterValueToOutcomeAnalyses < ActiveRecord::Migration
  def self.up
  	remove_column :outcome_analyses, :adjusted_estimation_parameter_value
  end

  def self.down
  	add_column :outcome_analyses, :adjusted_estimation_parameter_value, :integer
  end
end
