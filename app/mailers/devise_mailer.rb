class DeviseMailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers
  default template_path: 'users/mailer'

  def create_password_instructions(record, token, opts = {})
    @token = token
    devise_mail(record, :create_password_instructions, opts)
  end
end
