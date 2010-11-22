class RemoveUnnecessaryFields < ActiveRecord::Migration
  def self.up
	remove_column :population_characteristics, :arm_id
	remove_column :population_characteristics, :subcategory
	remove_column :outcome_timepoints, :study_id
	remove_column :outcome_enrolled_numbers, :is_total
	remove_column :population_characteristic_subcategories, :value
	remove_column :key_questions, :description
  end

  def self.down
  	add_column :population_characteristics, :arm_id, :integer
	add_column :population_characteristics, :subcategory, :string
	add_column :outcome_timepoints, :study_id, :integer
	add_column :outcome_enrolled_numbers, :is_total, :boolean
	add_column :population_characteristic_subcategories, :value, :string
  end
end
