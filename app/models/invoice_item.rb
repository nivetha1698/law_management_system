class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :service

  # before_save :calculate_total_price

  # private

  # def calculate_total_price
  #   self.total_price = unit_price * quantity
  # end
end
