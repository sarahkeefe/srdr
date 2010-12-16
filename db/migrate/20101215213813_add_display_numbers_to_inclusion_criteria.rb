class AddDisplayNumbersToInclusionCriteria < ActiveRecord::Migration
  def self.up
	add_column :inclusion_criteria_items, :display_number, :integer
	add_column :exclusion_criteria_items, :display_number, :integer
  end

  def self.down
	remove_column :inclusion_criteria_items, :display_number
	remove_column :exclusion_criteria_items, :display_number  
  end
end
