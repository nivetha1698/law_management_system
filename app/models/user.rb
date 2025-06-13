class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  rolify
  ADMIN_ROLES = %w[admin client lawyer judge]
  #---------------------------------------Associations------------------------------------------------
  has_one_attached :profile_image
  has_many :assigned_tasks, class_name: "Task", foreign_key: "assigned_to"
  has_many :time_entries
  has_many :reminders, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :audit_logs
  belongs_to :team, optional: true
  belongs_to :country, optional: true
  #-------------------------------------Validations---------------------------------------------------

  validates :name, :email, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  #--------------------------------------Callbacks-----------------------------------------------------

  after_create_commit :send_welcome_email

  #------------------------------------Methods------------------------------------------------------

  def send_welcome_email
    UserMailer.send_welcome_email(self).deliver_now
  end
end
