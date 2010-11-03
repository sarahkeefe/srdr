class CreateOutcomeTimepointResults < ActiveRecord::Migration
  def self.up
    create_table :outcome_timepoint_results do |t|
      t.integer :outcome_id
      t.integer :study_id
      t.integer :arm_id
      t.integer :timepoint_id
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_timepoint_results
  end
end
