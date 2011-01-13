class AddAdverseEventIdToAdverseEventResults < ActiveRecord::Migration
  def self.up
	add_column :adverse_event_results, :adverse_event_id, :integer
  end

  def self.down
	remove_column :adverse_event_results, :adverse_event_id
  end
end
