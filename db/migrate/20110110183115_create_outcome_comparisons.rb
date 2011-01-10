class CreateOutcomeComparisons < ActiveRecord::Migration
  def self.up
    create_table :outcome_comparisons do |t|
      t.integer :arm_id
      t.integer :outcome_id
      t.integer :timepoint_id
      t.integer :outcome_comparison_column_id
      t.boolean :is_calculated
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_comparisons
  end
end
