class CertificateTemplatesController < ApplicationController

  load_and_authorize_resource
  before_action :set_list_for_select, only: [:index, :new, :edit, :update, :create]
  before_action :set_certificate_template, only: [:show, :edit, :update, :destroy]
  before_action :set_filter_object, only: [:index]

  # GET /certificate_templates
  def index
    @certificate_templates = FindCertificateTemplate.find(@filter, page_params)
  end

  # GET /certificate_templates/1
  def show
  end

  # GET /certificate_templates/new
  def new
    @certificate_template = CertificateTemplate.new
  end

  # GET /certificate_templates/1/edit
  def edit
  end

  # POST /certificate_templates
  def create
    @certificate_template = CertificateTemplate.new(certificate_template_params)
    @certificate_template.person = current_user.person

    if @certificate_template.save
      redirect_to @certificate_template, success: 'Certificate template was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /certificate_templates/1
  def update
    if @certificate_template.update(certificate_template_params)
      redirect_to @certificate_template, success: 'Certificate template was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /certificate_templates/1
  def destroy
    @certificate_template.destroy
    redirect_to certificate_templates_url, success: 'Certificate template was successfully destroyed.'
  end

  def load_selected_signatures
    @certificate_signatures = CertificateSignature.where(id: params[:selecteds])
  end

  def arquive
    @certificate_template.current_user = current_user
    @certificate_template.archive
    respond_to do |format|
      format.html { redirect_to certificate_templates_url, success: 'Template arquivado com sucesso.' }
    end
  end

  def unarchive
    @certificate_template.current_user = current_user
    @certificate_template.unarchive
    respond_to do |format|
      format.html { redirect_to certificate_templates_url, success: 'Template desarquivado com sucesso.' }
    end
  end

  private

  def set_filter_object
    @params = params[:filter] || {}
    if @params[:certificate_signatures].present?
      @certificate_signatures = CertificateSignature.where(id: @params[:certificate_signatures]).map { |v| ["#{v.name} - #{v.role}", v.id] }
    end
    @filter = Filter.new({
                             name: @params[:name],
                             event_category: @params[:event_category],
                             archived: Util.to_boolean(@params[:archived]),
                             certificate_signatures: @params[:certificate_signatures],
                         })
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_certificate_template
    @certificate_template = CertificateTemplate.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_list_for_select
    @event_categories = EventCategory.select(:name, :id).map { |k, v| [k.name, k.id] }
  end

  # Only allow a trusted parameter "white list" through.
  def certificate_template_params
    return nil unless params[:certificate_template].present?
    params.require(:certificate_template).permit(:body, :event_category_id, :default,
                                                 image_attributes: [:file],
                                                 certificate_signature_ids: [])
  end

  def send_invoice_pdf
    send_file invoice_pdf.to_pdf,
              filename: invoice_pdf.filename,
              type: "application/pdf",
              disposition: "inline"
  end
end
