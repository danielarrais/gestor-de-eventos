class CertificateSignaturesController < ApplicationController

  before_action :set_certificate_signature, only: [:show, :edit, :update, :destroy, :arquive]
  before_action :set_filter_object, only: [:index]

  # GET /certificate_signatures
  # GET /certificate_signatures.json
  def index
    @certificate_signatures = FindCertificateSignature.find(@filter, page_params)
  end

  # GET /certificate_signatures/1
  # GET /certificate_signatures/1.json
  def show
  end

  # GET /certificate_signatures/new
  def new
    @certificate_signature = CertificateSignature.new
  end

  # GET /certificate_signatures/1/edit
  def edit
  end

  # POST /certificate_signatures
  # POST /certificate_signatures.json
  def create
    @certificate_signature = CertificateSignature.new(certificate_signature_params)

    respond_to do |format|
      if @certificate_signature.save
        format.html { redirect_to @certificate_signature, success: 'Certificate signature was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def autocomplete_by_name_or_role
    @certificate_signatures = CertificateSignature.select(:id, :name, :role)
                                .limit(10)
                                .where("certificate_signatures.name like ? or certificate_signatures.role like ? ", "%#{params[:value]}%", "%#{params[:value]}%")
                                .map { |v| { label: "#{v.name} - #{v.role}",
                                             value: v.id,
                                             id: v.id } }

    respond_to do |format|
      format.json { render json: @certificate_signatures }
    end
  end

  # PATCH/PUT /certificate_signatures/1
  # PATCH/PUT /certificate_signatures/1.json
  def update
    respond_to do |format|
      if @certificate_signature.update(certificate_signature_params)
        format.html { redirect_to @certificate_signature, success: 'Certificate signature was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def arquive
    @certificate_signature.current_user = current_user
    @certificate_signature.archive
    respond_to do |format|
      format.html { redirect_to certificate_signatures_url, success: 'Assinatura arquivada com sucesso.' }
    end
  end

  def unarchive
    @certificate_signature.current_user = current_user
    @certificate_signature.unarchive
    respond_to do |format|
      format.html { redirect_to certificate_signatures_url, success: 'Assinatura desarquivada com sucesso.' }
    end
  end

  # DELETE /certificate_signatures/1
  # DELETE /certificate_signatures/1.json
  def destroy
    @certificate_signature.destroy
    respond_to do |format|
      format.html { redirect_to certificate_signatures_url, success: 'Assinatura removida com sucesso.' }
    end
  end

  private

  def set_filter_object
    @params = params[:filter] || {}
    @filter = Filter.new({ name: @params[:name],
                           role: @params[:role],
                           archived: Util.to_boolean(@params[:archived]),
                           certificate_signatures: @params[:certificate_signatures] })
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_certificate_signature
    @certificate_signature = CertificateSignature.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def certificate_signature_params
    return nil unless params[:certificate_signature].present?
    params.require(:certificate_signature).permit(:name, :role, image_attributes: [:file])
  end
end
