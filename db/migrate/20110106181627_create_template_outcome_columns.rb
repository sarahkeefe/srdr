class CreateTemplateOutcomeColumns < ActiveRecord::Migration
  def self.up
    create_table :template_outcome_columns do |t|
      t.integer :template_id
      t.integer :column_id

      t.timestamps
    end
  end

  def self.down
    drop_table :template_outcome_columns
  end
end
