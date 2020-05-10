class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  default_form_builder ArgonFormBuilder

  before_action :authenticate_user!
  before_action :set_raven_context
  # before_action :verify_user_registration

  # # Verifica se o usuário possui o cadastro completo, caso não redireciona para página de completar o cadastro
  # def verify_user_registration
  #   if current_user.present? && !current_user.person.present?
  #     respond_to do |format|
  #       format.html { redirect_to complete_registration_users_path }
  #     end
  #   end
  # end

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
