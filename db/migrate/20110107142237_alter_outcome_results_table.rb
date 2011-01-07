class AlterOutcomeResultsTable < ActiveRecord::Migration
  def self.up
	add_column :outcome_results, :outcome_column_id, :integer
	add_column :outcome_results, :value, :string
	add_column :outcome_results, :is_calculated, :boolean
	remove_column :outcome_results, :study_id
	remove_column :outcome_results, :n_analyzed
	remove_column :outcome_results, :measure_type
	remove_column :outcome_results, :measure_value
	remove_column :outcome_results, :measure_dispersion_type
	remove_column :outcome_results, :measure_dispersion_value
	remove_column :outcome_results, :nanalyzed_is_calculated
	remove_column :outcome_results, :pvalue_is_calculated
	remove_column :outcome_results, :subgroup_id
	remove_column :outcome_results, :value
	remove_column :outcome_results, :measuredisp_is_calculated
	remove_column :outcome_results, :column_type
	remove_column :outcome_results, :column_name
	remove_column :outcome_results, :column_value
	remove_column :outcome_results, :column_id
	
  end

  def self.down
  end
end
