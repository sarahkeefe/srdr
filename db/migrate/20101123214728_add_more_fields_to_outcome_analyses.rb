class AddMoreFieldsToOutcomeAnalyses < ActiveRecord::Migration
  def self.up
  	add_column :outcome_analyses, :statistical_test, :string
  	add_column :outcome_analyses, :unadjusted_ci_level, :string
  	add_column :outcome_analyses, :unadjusted_ci_lower_limit, :integer
  	add_column :outcome_analyses, :unadjusted_ci_upper_limit, :integer
  	add_column :outcome_analyses, :adjusted_ci_level, :string
  	add_column :outcome_analyses, :adjusted_ci_lower_limit, :integer
  	add_column :outcome_analyses, :adjusted_ci_upper_limit, :integer
  	
  end

  def self.down
    remove_column :outcome_analyses, :statistical_test
  	remove_column :outcome_analyses, :unadjusted_ci_level
  	remove_column :outcome_analyses, :unadjusted_ci_lower_limit
  	remove_column :outcome_analyses, :unadjusted_ci_upper_limit
  	remove_column :outcome_analyses, :adjusted_ci_level
  	remove_column :outcome_analyses, :adjusted_ci_lower_limit
  	remove_column :outcome_analyses, :adjusted_ci_upper_limit
  	
  	
  end
end
