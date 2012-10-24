class CreateTools < ActiveRecord::Migration
  def change
    create_table :tools do |t|
      t.string :name
      t.references :user_group

      t.timestamps
    end
    add_index :tools, :user_group_id
  end
end
