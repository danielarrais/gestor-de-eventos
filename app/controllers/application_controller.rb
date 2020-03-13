class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :verify_user_registration

  # Verifica se o usuário possui o cadastro completo, caso não redireciona para página de completar o cadastro
  def verify_user_registration
    unless current_user.person.present?
      respond_to do |format|
        format.html { redirect_to complete_registration_users_path }
      end
    end
  end
end
