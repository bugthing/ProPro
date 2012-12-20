class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :chart_id
      t.integer :current_reading_line_id

      t.timestamps
    end
  end
end
