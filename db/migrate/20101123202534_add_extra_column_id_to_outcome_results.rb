class AddExtraColumnIdToOutcomeResults < ActiveRecord::Migration
  def self.up
	add_column :outcome_results, :column_id, :integer
	add_column :outcome_results, :column_type, :string
  end

  def self.down
	remove_column :outcome_results, :column_id
	remove_column :outcome_results, :column_type  
  end
end
