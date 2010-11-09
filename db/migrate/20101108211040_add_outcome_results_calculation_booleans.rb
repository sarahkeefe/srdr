class AddOutcomeResultsCalculationBooleans < ActiveRecord::Migration
  def self.up
	add_column :outcome_results, :nanalyzed_is_calculated, :boolean
	add_column :outcome_results, :measurereg_is_calculated, :boolean
	add_column :outcome_results, :measuredisp_is_calculated, :boolean
	add_column :outcome_results, :pvalue_is_calculated, :boolean		
  end

  def self.down
	remove_column :outcome_results, :nanalyzed_is_calculated
	remove_column :outcome_results, :measurereg_is_calculated
	remove_column :outcome_results, :measuredisp_is_calculated
	remove_column :outcome_results, :pvalue_is_calculated	  
  end
end
