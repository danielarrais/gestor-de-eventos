Dir["services/*.rb"].each { |file| require file }

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  default_form_builder CertEventsFormBuilder
  add_flash_types :info, :error, :warning, :success

  before_action :authenticate_user!
  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def send_pdf(content, name_file)
    pdf = PDFKit.new(content)
    pdf.stylesheets << "#{Rails.root}/node_modules/bootstrap/dist/css/bootstrap-grid.min.css"
    pdf.stylesheets << "#{Rails.root}/app/javascript/css/reports/certificate.css"
    pdf = pdf.to_pdf

    send_data(pdf, filename: name_file.upcase, type: "application/pdf", :disposition => 'attachment')
  end

  def page_params
    {
      page: params[:page] || 1
    }
  end
end
