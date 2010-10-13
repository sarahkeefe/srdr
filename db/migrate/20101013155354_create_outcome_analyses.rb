class CreateOutcomeAnalyses < ActiveRecord::Migration
  def self.up
    create_table :outcome_analyses do |t|
      t.integer :study_id
      t.string :outcome_name
      t.integer :arm1_id
      t.integer :arm2_id
      t.string :categorical_or_continuous
      t.float :n_analyzed
      t.float :n_total
      t.float :n_event
      t.string :estimation_parameter_type
      t.string :estimation_parameter_value
      t.string :parameter_dispersion_type
      t.string :parameter_dispersion_value
      t.float :p_value
      t.string :adjusted_parameter_dispersion_type
      t.string :adjusted_parameter_dispersion_value
      t.float :adjusted_p_value

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_analyses
  end
end
