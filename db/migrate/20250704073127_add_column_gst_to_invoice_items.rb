class AddColumnGstToInvoiceItems < ActiveRecord::Migration[8.0]
  def change
    add_column :invoice_items, :gst, :string
  end
end
