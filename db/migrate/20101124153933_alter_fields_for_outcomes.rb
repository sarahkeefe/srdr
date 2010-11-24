class AlterFieldsForOutcomes < ActiveRecord::Migration
  def self.up
	add_column :outcome_results, :timepoint_id, :integer
	add_column :outcome_results, :subgroup_id, :integer
	add_column :outcome_columns, :timepoint_id, :integer
	add_column :outcome_columns, :subgroup_id, :integer	
	drop_table :outcome_enrolled_numbers
	drop_table :forms
	drop_table :static_pages
	drop_table :outcome_timepoint_results
  end

  def self.down
	remove_column :outcome_results, :timepoint_id
	remove_column :outcome_results, :subgroup_id
	remove_column :outcome_columns, :timepoint_id
	remove_column :outcome_columns, :subgroup_id
	create_table :outcome_timepoint_results do |t|
      t.integer :outcome_id
      t.integer :study_id
      t.integer :arm_id
      t.integer :timepoint_id
      t.string :value

      t.timestamps
    end
	    create_table :outcome_enrolled_numbers do |t|
      t.integer :arm_id
      t.integer :outcome_id
      t.integer :num_enrolled

      t.timestamps
    end
  end
end
