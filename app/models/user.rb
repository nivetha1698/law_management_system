class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #---------------------------------------Associations------------------------------------------------
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assigned_to"
  has_many :issued_invoices, class_name: "Invoice", foreign_key: "issued_to_id"
  has_many :time_entries
  has_many :reminders, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :audit_logs
  belongs_to :team, optional: true
end
