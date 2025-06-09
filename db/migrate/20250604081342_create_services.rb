class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :name
      t.string :description
      t.decimal :amount, precision: 10, scale: 2
      t.timestamps
    end
  end
end
