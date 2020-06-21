class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  # GET /participants
  def index
    @participants = Participant.all.page(params[:page]).per(10)
  end

  # GET /participants/1
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
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
      redirect_to @participant, success: 'Participant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /participants/1
  def destroy
    @form_id = params[:id_form]
    if @participant.present?
      @participant.destroy
      flash[:success] = 'Participante removido com sucesso'
    else
      flash[:warning] = 'Participante não existe'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_participant
    if Participant.exists?(params[:id])
      @participant = Participant.find(params[:id])
    end
  end

  # Only allow a trusted parameter "white list" through.
  def participant_params
    params.require(:participant).permit(:person_id, :frequence_id, :type_participation_id,
                                        :event_id, :status, :workload, person_attributes: [:cpf, :name])
  end
end
