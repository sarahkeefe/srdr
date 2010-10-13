class CreateOutcomes < ActiveRecord::Migration
  def self.up
    create_table :outcomes do |t|
      t.integer :study_id
      t.string :title
      t.string :type
      t.boolean :is_primary
      t.string :units
      t.text :description
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :outcomes
  end
end
