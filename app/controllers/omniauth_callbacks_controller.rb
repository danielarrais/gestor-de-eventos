class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_user!

  def google_oauth2
    auth = request.env["omniauth.auth"]
    user = User.where(provider: auth["provider"], uid: auth["uid"])
               .first_or_initialize(email: auth["info"]["email"])

    if user.new_record?
      user.build_person

      user.person.name = auth["info"]["first_name"]
      user.person.surname = auth["info"]["last_name"]

      user.save!
    end

    sign_in(:user, user)

    redirect_to after_sign_in_path_for(user)
  end
end
