class UserMailer < ActionMailer::Base
  default :from => 'ascherit999@gmail.com'

  def registration_confirmation(user, origin)
    @user = user
    @origin = origin
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registration Confirmation")
  end
end