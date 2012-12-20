class CreateReadingLines < ActiveRecord::Migration
  def change
    create_table :reading_lines do |t|
      t.integer :reading_id
      t.integer :section_id
      t.timestamps
    end
  end
end
