class AddArmIdToAdverseEvents < ActiveRecord::Migration
  def self.up
	add_column :adverse_events, :arm_id, :integer
  end

  def self.down
	remove_column :adverse_events, :arm_id
  end
end
