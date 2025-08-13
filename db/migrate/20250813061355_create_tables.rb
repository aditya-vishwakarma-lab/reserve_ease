class CreateTables < ActiveRecord::Migration[8.0]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :capacity
      t.string :area
      t.text :features

      t.timestamps
    end
  end
end
