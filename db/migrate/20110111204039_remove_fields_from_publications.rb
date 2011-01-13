class RemoveFieldsFromPublications < ActiveRecord::Migration
  def self.up
	remove_column :publications, :is_primary
	remove_column :publications, :ui_type
	remove_column :publications, :ui
  end

  def self.down
  	add_column :publications, :is_primary, :boolean
	add_column :publications, :ui_type, :string
	add_column :publications, :ui, :string
  end
end
