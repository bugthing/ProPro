class CreateSectionLines < ActiveRecord::Migration
  def change
    create_table :section_lines do |t|
      t.references :tool
      t.references :section

      t.timestamps
    end
    add_index :section_lines, :tool_id
    add_index :section_lines, :section_id
  end
end
