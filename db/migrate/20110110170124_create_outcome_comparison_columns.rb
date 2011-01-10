class CreateOutcomeComparisonColumns < ActiveRecord::Migration
  def self.up
    create_table :outcome_comparison_columns do |t|
      t.string :column_header
      t.string :outcome_type
      t.string :column_name
      t.string :column_description
      t.integer :template_id
      t.integer :study_id

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_comparison_columns
  end
end
