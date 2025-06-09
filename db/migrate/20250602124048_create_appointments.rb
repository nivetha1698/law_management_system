class CreateAppointments < ActiveRecord::Migration[8.0]
  def change
    create_table :appointments do |t|
      t.date :date
      t.time :time
      t.references :client, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
