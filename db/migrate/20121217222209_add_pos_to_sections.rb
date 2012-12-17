class AddPosToSections < ActiveRecord::Migration
  def change
    add_column :sections, :pos_left, :integer
    add_column :sections, :pos_top, :integer
  end
end
