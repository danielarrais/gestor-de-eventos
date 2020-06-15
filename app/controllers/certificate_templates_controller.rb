class CertificateTemplatesController < ApplicationController
  before_action :set_list_for_select, only: [:new, :edit, :update, :create]
  before_action :set_certificate_template, only: [:show, :edit, :update, :destroy]

  # GET /certificate_templates
  def index
    @certificate_templates = CertificateTemplate.all.page(params[:page]).per(10)
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

  private

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
    params.require(:certificate_template).permit(:body, :event_category_id, image_attributes: [:file],
                                                 certificate_signature_ids: [])
  end
end
