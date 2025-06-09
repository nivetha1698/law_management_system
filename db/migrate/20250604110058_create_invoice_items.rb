class CreateInvoiceItems < ActiveRecord::Migration[8.0]
  def change
    create_table :invoice_items do |t|
      t.string :item
      t.string :quantity
      t.string :unit_price
      t.string :cgst
      t.string :sgst
      t.string :total
      t.references :service, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.timestamps
    end
  end
end
