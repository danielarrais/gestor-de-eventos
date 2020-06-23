require "csv"

class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy, :certificate_download]
  before_action :set_list_for_select, only: [:edit, :new]

  # GET /participants
  def index
    @participants = Participant.all.where(cpf: current_user.person.cpf, status: :certified).page(params[:page]).per(10)
  end

  # GET /participants/1
  def show
  end

  # GET /participants/new
  def new
    if params[:event].present? && params[:frequence].present?
      @participant = Participant.new(event_id: params[:event], frequence_id: params[:frequence])
    else
      flash[:error] = "Evento ou frequência não encontrados"
    end
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  def create
    @form_id = params[:id_form]
    @participant = Participant.new(participant_params)
    @participant.status = :awaiting_certificate
    if @participant.save
      flash[:success] = 'Participante adicionado com sucesso'
    end
  end

  def certificate_download
    event = @participant.event
    certificate_template = event.certificate_template
    url_image = @participant.event.parent_event&.image&.url || certificate_template.image&.url

    name_file = "#{event.event_category.name} - #{event.name} - #{event.start_date.strftime('%d%m%Y')}.pdf"

    text = CertificateTemplate::process_template_for_participant(@participant)

    html_string = render_to_string('imprimir',
                     layout: false,
                     locals: { text: text,
                               certificate_signatures: certificate_template.certificate_signatures,
                               url: url_image })

    pdf = PDFKit.new(html_string)
    pdf.stylesheets << "#{Rails.root}/node_modules/bootstrap/dist/css/bootstrap-grid.min.css"
    pdf = pdf.to_pdf

    send_data(pdf, filename: name_file.upcase, type: "application/pdf", :disposition => 'attachment')
  end

  # PATCH/PUT /participants/1
  def update
    if @participant.update(participant_params)
      flash[:success] = 'Participante atualizado com sucesso'
    end
  end

  # DELETE /participants/1
  def destroy
    if @participant.present?
      @participant.destroy
      flash[:success] = 'Participante removido com sucesso'
    else
      flash[:warning] = 'Participante não existe'
    end
  end

  def import_from_csv
    if params[:event].present? && params[:frequence].present?
      @event = Event.find(params[:event].to_i)
      @frequence = Frequence.find(params[:frequence].to_i)
      @type_participation = TypeParticipation.find_by_key(:ouvinte)
      @arquive = Archive.new(arquive_params)
      @arquive.origin = @event
      @arquive.save

      File.open("planilha.csv", 'w') { |file| file.write(@arquive.content) }

      file = File.open("planilha.csv", "r")
      CSV.parse(file).map { |x| x[0] }.each_with_index do |row, i|
        next if i == 0
        data = row.split(";")

        participant = Participant.find_or_create_by(event: @event,
                                                    frequence: @frequence,
                                                    cpf: data[3])

        participant.name = data[0]
        participant.surname = data[1]
        participant.registration = data[4]
        participant.cpf = data[3]
        participant.email = data[2]
        participant.workload = @event.workload
        participant.type_participation = @type_participation
        participant.status = :awaiting_certificate

        participant.save
      end
      file.close
      @participants = Participant.where(event_id: @event, frequence_id: @frequence)
      flash[:success] = "Importação realizada com sucesso"
    else
      flash[:error] = "Evento ou frequência não encontrados"
    end
  end

  private

  def set_list_for_select
    @type_participations = TypeParticipation.select(:name, :id).map { |k, v| [k.name, k.id] }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    if Participant.exists?(params[:id])
      @participant = Participant.find(params[:id])
    end
  end

  # Only allow a trusted parameter "white list" through.
  def participant_params
    params.require(:participant).permit(:person_id, :frequence_id, :type_participation_id, :email,
                                        :event_id, :status, :workload, :cpf, :name, :surname, :registration)
  end

  # Only allow a trusted parameter "white list" through.
  def arquive_params
    params.require(:arquive).permit(:file)
  end
end
