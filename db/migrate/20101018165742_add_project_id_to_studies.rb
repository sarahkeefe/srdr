class AddProjectIdToStudies < ActiveRecord::Migration
  def self.up
	add_column :studies, :project_id, :integer
  end

  def self.down
	remove_column :studies, :project_id
  end
end
