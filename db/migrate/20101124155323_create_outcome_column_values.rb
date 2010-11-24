class CreateOutcomeColumnValues < ActiveRecord::Migration
  def self.up
    create_table :outcome_column_values do |t|
      t.integer :outcome_id
      t.integer :timepoint_id
      t.integer :subgroup_id
      t.string :value
      t.boolean :is_calculated

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_column_values
  end
end
