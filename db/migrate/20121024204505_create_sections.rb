class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.references :chart

      t.timestamps
    end
    add_index :sections, :chart_id
  end
end
