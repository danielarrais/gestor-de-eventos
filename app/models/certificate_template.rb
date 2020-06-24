class CertificateTemplate < ApplicationRecord
  belongs_to :image, required: false
  belongs_to :person, required: false
  belongs_to :event_category, required: false
  has_and_belongs_to_many :certificate_signatures

  before_validation :set_file_extensions
  after_update :set_default_template

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) { x[:file].nil? }

  TAGS_TEMPLATES = {
      nome_aluno: 'Nome do Participante',
      carga_horaria: 'Carga Horária',
      nome_completo_evento: 'Nome Completo do Evento/Atividade',
      nome_evento: 'Nome do Evento/Atividade',
      tipo_participacao: 'Tipo de Participação',
      data_inicio: 'Data de Inicío',
      data_encerramento: 'Data de Encerramento',
  }.freeze

  def self.default_certificate(event_category_id)
    CertificateTemplate.where(default: true, event_category_id: event_category_id).order(updated_at: :desc).limit(1).first
  end

  private

  # Defines the allowed image formats
  def set_default_template
    return unless default
    CertificateTemplate.where.not(id: self.id).where(default: true, event_category_id: event_category_id).each do |template|
      template.update_attribute(:default, false)
    end
  end

  # Defines the allowed image formats
  def set_file_extensions
    self.image.allowed_extensions = [:png, :jpg, :jpeg] if self.image.present?
  end
end
