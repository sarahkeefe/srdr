class CreateOutcomeResults < ActiveRecord::Migration
  def self.up
    create_table :outcome_results do |t|
      t.integer :study_id
      t.integer :timepoint_id
      t.integer :arm_id
      t.integer :n_analyzed
      t.string :measure_type
      t.string :measure_value
      t.string :measure_dispersion_type
      t.string :measure_dispersion_value
      t.string :p_value

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_results
  end
end
