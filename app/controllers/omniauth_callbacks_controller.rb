class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  def google_oauth2
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth["provider"], uid: auth["uid"])
               .first_or_initialize(email: auth["info"]["email"])

    first_login = user.new_record?

    if first_login
      user.name = auth["info"]["first_name"]
      user.save
    end

    sign_in(:user, user)

    redirect_to complete_registration_users_path if first_login
    redirect_to after_sign_in_path_for(user) unless first_login
  end
end
