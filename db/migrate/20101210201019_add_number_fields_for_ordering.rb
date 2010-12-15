class AddNumberFieldsForOrdering < ActiveRecord::Migration
  def self.up
	add_column :publications, :display_number, :integer
	add_column :arms, :display_number, :integer
	add_column :population_characteristics, :display_number, :integer
	add_column :adverse_events, :display_number, :integer
	add_column :quality_aspects, :display_number, :integer
	end

  def self.down
	remove_column :publications, :display_number
	remove_column :arms, :display_number
	remove_column :population_characteristics, :display_number
	remove_column :adverse_events, :display_number
	remove_column :quality_aspects, :display_number
  end
end
