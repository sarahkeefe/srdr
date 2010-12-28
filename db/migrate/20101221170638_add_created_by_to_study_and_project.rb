class AddCreatedByToStudyAndProject < ActiveRecord::Migration
  def self.up
	add_column :studies, :creator_id, :integer
	add_column :projects, :creator_id, :integer
  end

  def self.down
	remove_column :studies, :creator_id
	remove_column :projects, :creator_id
  end
end
