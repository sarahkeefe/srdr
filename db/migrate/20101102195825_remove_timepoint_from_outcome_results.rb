class RemoveTimepointFromOutcomeResults < ActiveRecord::Migration
  def self.up
	remove_column :outcome_results, :timepoint_id
  end

  def self.down
	add_column :outcome_results, :timepoint_id, :integer
  end
end
