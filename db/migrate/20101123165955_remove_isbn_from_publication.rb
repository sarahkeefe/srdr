class RemoveIsbnFromPublication < ActiveRecord::Migration
  def self.up
  	remove_column :publications, :isbn
	  add_column :projects, :isbn, :string
  end

  def self.down
  	add_column :publications, :isbn, :string
  	remove_column :projects, :isbn
  end
end
