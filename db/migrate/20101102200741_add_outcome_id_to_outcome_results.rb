class AddOutcomeIdToOutcomeResults < ActiveRecord::Migration
  def self.up
	add_column :outcome_results, :outcome_id, :integer
  end

  def self.down
	remove_column :outcome_results, :outcome_id
  end
end
