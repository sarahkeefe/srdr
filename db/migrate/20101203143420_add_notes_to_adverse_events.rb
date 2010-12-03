class AddNotesToAdverseEvents < ActiveRecord::Migration
  def self.up
	add_column :adverse_events, :notes, :text
  end

  def self.down
	remove_column :adverse_events, :notes
  end
end
