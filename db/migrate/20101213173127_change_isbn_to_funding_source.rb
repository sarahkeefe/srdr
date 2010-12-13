class ChangeIsbnToFundingSource < ActiveRecord::Migration
  def self.up
	remove_column :projects, :isbn
	add_column :projects, :funding_source, :text
  end

  def self.down
	remove_column :projects, :funding_source
	add_column :projects, :isbn, :string  
  end
end
