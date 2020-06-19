class CertificateTemplate < ApplicationRecord
  belongs_to :image, required: false
  belongs_to :person, required: false
  belongs_to :event_category, required: false
  has_and_belongs_to_many :certificate_signatures

  before_validation :set_file_extensions

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) {x[:file].nil?}

  TAGS_TEMPLATES = {
      nome_aluno: 'Nome do Participante',
      carga_horaria: 'Carga Horária',
      nome_evento_pai: 'Nome do Evento Principal',
      nome_evento: 'Nome do Sub Evento',
      tipo_participacao: 'Tipo de Participação',
      data_inicio: 'Data de Inicío',
      data_encerramento: 'Data de Encerramento',
  }.freeze

  private

  # Defines the allowed image formats
  def set_file_extensions
    self.image.allowed_extensions = [:png, :jpg, :jpeg] if self.image.present?
  end
end
