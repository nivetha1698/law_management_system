class CreateTimeEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :time_entries do |t|
      t.references :user, foreign_key: true
      t.references :case, foreign_key: true
      t.text :description
      t.decimal :hours, precision: 6, scale: 2
      t.decimal :rate, precision: 8, scale: 2
      t.boolean :billable, default: true
      
      t.timestamps
    end
  end
end
