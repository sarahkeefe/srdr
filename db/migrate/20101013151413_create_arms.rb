class CreateArms < ActiveRecord::Migration
  def self.up
    create_table :arms do |t|
      t.integer :study_id
      t.string :title
      t.text :description
      t.integer :num_participants

      t.timestamps
    end
  end

  def self.down
    drop_table :arms
  end
end
