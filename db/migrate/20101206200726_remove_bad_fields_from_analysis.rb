class RemoveBadFieldsFromAnalysis < ActiveRecord::Migration
  def self.up
  	remove_column :outcome_analyses, :parameter_dispersion_value
  	remove_column :outcome_analyses, :estimation_parameter_value
  	remove_column :outcome_analyses, :adjusted_parameter_dispersion_value
  	remove_column :outcome_analyses, :adjusted_estimation_parameter_value
  	remove_column :outcome_analyses, :adjusted_dispersion_parameter_value
  	
  end

  def self.down
  	add_column :outcome_analyses, :parameter_dispersion_value, :float
  	add_column :outcome_analyses, :estimation_parameter_value, :float
  	add_columnn :outcome_analyses, :adjusted_parameter_dispersion_value, :float
  	add_column :outcome_analyses, :adjusted_estimation_parameter_value, :float
  	add_column :outcome_analyses, :adjusted_dispersion_parameter_value, :float
  end
end
