class AddUserGroupToUser < ActiveRecord::Migration
  def up
    add_column :users, :user_group_id, :integer
    add_index :users, :user_group_id
  end

  def down
    remove_index :users, :user_group_id
    remove_column :users, :user_group_id
  end
end
