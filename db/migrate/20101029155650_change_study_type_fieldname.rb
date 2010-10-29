class ChangeStudyTypeFieldname < ActiveRecord::Migration
  def self.up
	add_column :studies, :study_type, :string
	remove_column :studies, :type
  end

  def self.down
 	remove_column :studies, :study_type
	add_column :studies, :type, :string 
  end
end
