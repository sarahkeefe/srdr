class CreateOutcomeSubgroupLevels < ActiveRecord::Migration
  def self.up
    create_table :outcome_subgroup_levels do |t|
      t.integer :subgroup_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :outcome_subgroup_levels
  end
end
