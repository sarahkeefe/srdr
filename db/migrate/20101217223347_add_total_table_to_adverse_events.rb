class AddTotalTableToAdverseEvents < ActiveRecord::Migration
  def self.up
	add_column :adverse_events, :is_total, :boolean
  end

  def self.down
  	remove_column :adverse_events, :is_total
  end
end
