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
                                        :event_id, :status, :workload, person_attributes: [:cpf, :name, :registration])
  end
end
