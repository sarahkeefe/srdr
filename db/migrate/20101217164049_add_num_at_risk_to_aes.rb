class AddNumAtRiskToAes < ActiveRecord::Migration
  def self.up
	add_column :adverse_events, :num_affected, :integer
	add_column :adverse_events, :num_at_risk, :integer
  end

  def self.down
	remove_column :adverse_events, :num_affected
	remove_column :adverse_events, :num_at_risk 
  end
end
