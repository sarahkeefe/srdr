class AlterOutcomeResultsAgain < ActiveRecord::Migration
  def self.up
	add_column :outcome_results, :value, :string
	remove_column :outcome_results, :p_value
	remove_column :outcome_results, :measurereg_is_calculated
	
  end

  def self.down
  end
end
