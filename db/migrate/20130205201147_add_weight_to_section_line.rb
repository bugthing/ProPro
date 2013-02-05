class AddWeightToSectionLine < ActiveRecord::Migration
  def change
    add_column :section_lines, 'weight', :integer
  end
end
