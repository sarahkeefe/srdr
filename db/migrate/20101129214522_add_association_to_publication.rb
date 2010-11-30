class AddAssociationToPublication < ActiveRecord::Migration
  def self.up
  	add_column :publications, :association, :string
  end

  def self.down
  	remove_column :publications, :association
  end
end
