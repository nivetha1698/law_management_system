class ChangeTotalTypeInInvoiceItems < ActiveRecord::Migration[8.0]
  def change
    change_column :invoice_items, :total, :decimal, precision: 10, scale: 2, using: 'total::decimal'
  end
end
