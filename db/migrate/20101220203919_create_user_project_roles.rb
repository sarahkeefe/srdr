class CreateUserProjectRoles < ActiveRecord::Migration
  def self.up
    create_table :user_project_roles do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :user_project_roles
  end
end
