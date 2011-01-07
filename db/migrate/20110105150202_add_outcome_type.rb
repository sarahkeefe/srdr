class AddOutcomeType < ActiveRecord::Migration
  def self.up
	add_column :outcomes, :outcome_type, :string
	add_column :outcome_results, :column_name, :string
	add_column :outcome_results, :column_value, :string
  end

  def self.down
	remove_column :outcomes, :outcome_type  
	remove_column :outcome_results, :column_name
	remove_column :outcome_results, :column_value
  end
end
