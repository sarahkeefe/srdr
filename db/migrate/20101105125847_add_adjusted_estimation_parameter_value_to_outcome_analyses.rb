class AddAdjustedEstimationParameterValueToOutcomeAnalyses < ActiveRecord::Migration
  def self.up
  	add_column :outcome_analyses, :adjusted_estimation_parameter_value, :integer
  end

  def self.down
  	remove_column :outcome_analyses, :adjusted_estimation_parameter_value
  end
end
