class Invoice < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_keywords,
                  against: :invoice_number,
                  associated_against: { issued_to: [ :name ] },
                  using: { tsearch: { prefix: true } }

  #--------------------------------------Associations---------------------------------------
  belongs_to :court_case, class_name: "CourtCase", foreign_key: "case_id"
  belongs_to :issued_to, class_name: "Client", foreign_key: "issued_to_id"
  has_many :invoice_items, inverse_of: :invoice, dependent: :destroy
  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  #--------------------------------------Validations----------------------------------------
  validates :amount, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :status, :issued_at, :due_date, presence: true

  #--------------------------------------Callbacks-------------------------------------------
  before_save :calculate_total_amount
  before_create :set_invoice_number
  private

  def calculate_total_amount
    self.amount = invoice_items.includes(:service).sum { |f| f.service.amount }
  end

  def set_invoice_number
    date_part = Date.today.strftime("%Y%m")
    last_invoice = Invoice.where("invoice_number LIKE ?", "INV-#{date_part}-%").order(:invoice_number).last

    if last_invoice && last_invoice.invoice_number.present?
      last_seq = last_invoice.invoice_number.split("-").last.to_i
      new_seq = last_seq + 1
    else
      new_seq = 1
    end

    self.invoice_number = "INV-#{date_part}-#{new_seq.to_s.rjust(4, '0')}"
  end
end
