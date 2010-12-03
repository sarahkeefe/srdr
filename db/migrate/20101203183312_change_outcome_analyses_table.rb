class ChangeOutcomeAnalysesTable < ActiveRecord::Migration
  def self.up
  	remove_column :outcome_analyses, :estimation_parameter_value
  	remove_column :outcome_analyses, :dispersion_parameter_value
  	remove_column :outcome_analyses, :unadjusted_ci_lower_limit
  	remove_column :outcome_analyses, :adjusted_ci_lower_limit
  	remove_column :outcome_analyses, :adjusted_ci_upper_limit
  	remove_column :outcome_analyses, :unadjusted_ci_upper_limit
  	remove_column :outcome_analyses, :adjusted_estimation_parameter_value
  	remove_column :outcome_analyses, :adjusted_dispersion_parameter_value
  	add_column :outcome_analyses, :estimation_parameter_value, :float
  	add_column :outcome_analyses, :dispersion_parameter_value, :float
  	add_column :outcome_analyses, :unadjusted_ci_lower_limit, :float
  	add_column :outcome_analyses, :adjusted_ci_lower_limit, :float
  	add_column :outcome_analyses, :adjusted_ci_upper_limit, :float
  	add_column :outcome_analyses, :unadjusted_ci_upper_limit, :float
  	add_column :outcome_analyses, :adjusted_estimation_parameter_value, :float
  	add_column :outcome_analyses, :adjusted_dispersion_parameter_value, :float
  end

  def self.down
  	add_column :outcome_analyses, :estimation_parameter_value, :integer
  	add_column :outcome_analyses, :dispersion_parameter_value, :integer
  	add_column :outcome_analyses, :unadjusted_ci_lower_limit, :integer
  	add_column :outcome_analyses, :adjusted_ci_lower_limit, :integer
  	add_column :outcome_analyses, :adjusted_ci_upper_limit, :integer
  	add_column :outcome_analyses, :unadjusted_ci_upper_limit, :integer
  	add_column :outcome_analyses, :adjusted_estimation_parameter_value, :integer
  	add_column :outcome_analyses, :adjusted_dispersion_parameter_value, :integer
  	remove_column :outcome_analyses, :estimation_parameter_value
  	remove_column :outcome_analyses, :dispersion_parameter_value
  	remove_column :outcome_analyses, :unadjusted_ci_lower_limit
  	remove_column :outcome_analyses, :adjusted_ci_lower_limit
  	remove_column :outcome_analyses, :adjusted_ci_upper_limit
  	remove_column :outcome_analyses, :unadjusted_ci_upper_limit
  	remove_column :outcome_analyses, :adjusted_estimation_parameter_value
  	remove_column :outcome_analyses, :adjusted_dispersion_parameter_value
  end
end
