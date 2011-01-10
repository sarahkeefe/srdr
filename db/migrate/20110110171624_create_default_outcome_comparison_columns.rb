class CreateDefaultOutcomeComparisonColumns < ActiveRecord::Migration
  def self.up
    create_table :default_outcome_comparison_columns do |t|
      t.string :column_name
      t.string :column_description
      t.string :column_header
      t.string :outcome_type

      t.timestamps
    end
  end

  def self.down
    drop_table :default_outcome_comparison_columns
  end
end
