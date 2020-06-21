require "csv"

class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :set_list_for_select, only: [:edit, :new]

  # GET /participants
  def index
    @participants = Participant.all.page(params[:page]).per(10)
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
    @participant.status = 1
    if @participant.save
      flash[:success] = 'Participante adicionado com sucesso'
    end
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
        participant.status = 1

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
