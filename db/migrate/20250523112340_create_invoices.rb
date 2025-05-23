class CreateInvoices < ActiveRecord::Migration[7.2]
  def change
    create_table :invoices do |t|
      t.references :case, foreign_key: true
      t.references :issued_to, foreign_key: { to_table: :users }
      t.decimal :amount, precision: 10, scale: 2
      t.string :status, default: "unpaid"
      t.date :issued_at
      t.date :due_date
      
      t.timestamps
    end
  end
end
