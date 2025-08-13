class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :time_slot, null: false, foreign_key: true
      t.integer :party_size
      t.string :contact_phone

      t.timestamps
    end
  end
end
