class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :description
      t.datetime :date
      t.boolean :recursive
      t.integer :recurseDays

      t.timestamps
    end
  end
end
