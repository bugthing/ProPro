class AddUserGroupToChart < ActiveRecord::Migration
  def up
    add_column :charts, :user_group_id, :integer
    add_index :charts, :user_group_id
  end

  def down
    remove_index :charts, :user_group_id
    remove_column :charts, :user_group_id
  end
end
