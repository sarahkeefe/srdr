class AddCorrectFieldsToAnalysis < ActiveRecord::Migration
  def self.up
  	add_column :outcome_analyses, :estimation_parameter_value, :float
  	add_column :outcome_analyses, :parameter_dispersion_value, :float
  	add_column :outcome_analyses, :adjusted_estimation_parameter_value, :float
  	add_column :outcome_analyses, :adjusted_parameter_dispersion_value, :float
  end

  def self.down
  	remove_column :outcome_analyses, :estimation_parameter_value
  	remove_column :outcome_analyses, :parameter_dispersion_value
  	remove_column :outcome_analyses, :adjusted_estimation_parameter_value
  	remove_column :outcome_analyses, :adjusted_parameter_dispersion_value
  end
end
