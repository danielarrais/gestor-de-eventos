class EventRequest < ApplicationRecord
  include CSituation

  attr_accessor :justification_of_return, :draft

  belongs_to :event
  belongs_to :person, required: false

  accepts_nested_attributes_for :event, allow_destroy: false

  scope :waiting_for_analysis, -> {
    joins(situation: [:key_situation]).where('key_situations.key = ?', :forwarded).distinct
  }

  def create_initial_situation
    self.situations.create(person: person,
                           key_situation: KeySituation.find_by(key: self.draft ? :draft : :deferred))
  end

  def forwarded
    return if forwarded?
    self.situations.create(person: person,
                           key_situation: KeySituation.find_by(key: :forwarded)).save
    set_current_situation
  end

  def generate_event
    self.situations.create(person: current_user.person,
                           key_situation: KeySituation.find_by(key: :deferred)).save if forwarded?

    self.event.approve_event

    set_current_situation
  end

  def return_for_changes
    if justification_of_return.nil? || justification_of_return.empty?
      self.errors.add(:justification_of_return, 'é obrigatório')
    else
      self.situations.create(person: current_user.person,
                             observation: justification_of_return,
                             key_situation: KeySituation.find_by(key: :returned_for_correction)).save if forwarded?

      set_current_situation
    end
  end

  def can_action?(action)
    case self.situation&.key_situation&.key&.to_sym
    when :forwarded
      [:show, :generate_event, :return_for_changes].include?(action)
    when :deferred
      [:show].include?(action)
    when :draft
      [:show, :edit, :destroy, :forward_the_request].include?(action)
    when :returned_for_correction
      [:show, :edit, :forward_the_request].include?(action)
    else
      false
    end
  end

  def devolutions
    self.situations.to_a.select { |x| x.key_situation.key.to_sym == :returned_for_correction }
  end
end
