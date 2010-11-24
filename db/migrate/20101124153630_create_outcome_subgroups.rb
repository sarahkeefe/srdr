class CreateOutcomeSubgroups < ActiveRecord::Migration
  def self.up
    create_table :outcome_subgroups do |t|
      t.integer :outcome_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_subgroups
  end
end
