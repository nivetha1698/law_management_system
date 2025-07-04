class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :service

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total = unit_price * quantity + cgst + sgst
  end
end
