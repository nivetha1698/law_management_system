class UserMailer < ApplicationMailer
  def send_welcome_email(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: "Welcome to Law Management System")
  end
end
