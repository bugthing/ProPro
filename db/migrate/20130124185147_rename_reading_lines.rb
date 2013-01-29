class RenameReadingLines < ActiveRecord::Migration
  def self.up
    rename_table :reading_lines, :reading_sections
    rename_column :readings, :current_reading_line_id, :current_reading_section_id
  end 
  def self.down
    rename_table :reading_sections, :reading_lines
    rename_column :readings, :current_reading_section_id, :current_reading_line_id
  end
end
