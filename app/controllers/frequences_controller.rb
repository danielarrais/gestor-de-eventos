class FrequencesController < ApplicationController
  before_action :set_frequence, only: [:show, :edit, :update]

  # GET /frequences/1/edit
  def edit
  end

  # GET /frequences/1/edit
  def show
  end

  # PATCH/PUT /frequences/1
  def update
    if @frequence.update(frequence_params)
      redirect_to @frequence, success: 'Frequencia atualizada com sucesso'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_frequence
    if params[:event].present? && Event.exists?(params[:event].to_i).present?
      @frequence = Frequence.find_or_create_by(event_id: params[:event].to_i)
    else
      redirect_to events_path, error: 'Evento não encontrado.'
    end
  end

  # Only allow a trusted parameter "white list" through.
  def frequence_params
    params.require(:frequence).permit(:event_id)
  end
end
