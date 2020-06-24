class Event < ApplicationRecord
  after_create :create_initial_situation
  before_validation :set_file_extensions

  attr_accessor :current_user, :draft

  belongs_to :image, required: false
  belongs_to :parent_event, class_name: 'Event', foreign_key: 'event_id', required: false
  belongs_to :event_category
  belongs_to :certificate_template, required: false
  belongs_to :situation, required: false
  has_one :frequence
  has_many :situations, -> { order('created_at asc') }, as: :origin
  has_many :child_events, :class_name => "Event"
  has_many :participants, foreign_key: :event_id
  has_and_belongs_to_many :oriented_activities # use alias guiding

  validates_presence_of :name, :start_date, :closing_date, :event_category, :workload

  accepts_nested_attributes_for :image, allow_destroy: true, reject_if: -> (x) { x[:file].nil? }
  accepts_nested_attributes_for :oriented_activities, allow_destroy: true
  accepts_nested_attributes_for :child_events, allow_destroy: true

  scope :no_draft, -> {
    joins(situation: [:key_situation]).where('key_situations.key != ?', :draft).distinct
  }

  def create_initial_situation
    return if situation.present? || parent_event.present? || deferred? || !current_user.present?

    self.situations.create(person: current_user.person,
                           key_situation: KeySituation.find_by(key: :deferred))

    set_current_situation
  end

  def approve_event
    return if deferred?

    self.situations.create(person: current_user.person,
                           key_situation: KeySituation.find_by(key: :deferred))

    set_current_situation
  end

  def release_issuing_certificates
    load_and_select_templates

    return if !self.errors.empty? || parent_event.present?

    self.frequence.participants&.each do |participant|
      participant.update_attribute(:status, :certified) unless participant.certified?
    end

    self.situations.create(person: current_user.person,
                           key_situation: KeySituation.find_by(key: :released_certificates))

    set_current_situation
  end

  def last_situation
    self.situations&.last
  end

  def draft?
    situation&.key_situation&.key&.to_sym == :draft
  end

  def deferred?
    situation&.key_situation&.key&.to_sym == :deferred
  end

  def can_action?(action)
    case self.situation&.key_situation&.key&.to_sym
    when :deferred
      [:show, :edit, :destroy,
       :release_issuing_certificates, :edit_frequences].include?(action)
    when :draft
      [:show,].include?(action)
    when :released_certificates
      [:show, :edit_frequences, :release_issuing_certificates,].include?(action)
    else
      false
    end
  end

  def full_name
    [parent_event&.name, self.name].compact.join(' - ')
  end

  private

  def load_and_select_templates
    categorias_sem_template = []

    if child_events.any?
      child_events.each do |event|
        template = CertificateTemplate::default_certificate(event.event_category_id)
        if template.present?
          event.update_attribute(:certificate_template_id, template.id)
        else
          categorias_sem_template << event.event_category.name
        end
      end
    else
      template = CertificateTemplate::default_certificate(self.event_category_id)
      if template.present?
        self.certificate_template = template
      else
        categorias_sem_template << self.event_category.name
      end
    end

    message = "Não foi encontrado um template padrão para a(s) categoria(s)
               <b>#{categorias_sem_template.join('</b>, <b>')}</b>"
    self.errors.add(:base, message) if categorias_sem_template.any?
  end

  def set_current_situation
    self.situations.reload
    self.update_column(:situation_id, last_situation&.id)
  end

  # Defines the allowed image formats
  def set_file_extensions
    self.image.allowed_extensions = [:png, :jpg, :jpeg] if self.image.present?
  end
end
