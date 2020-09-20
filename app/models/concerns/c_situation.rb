module CSituation
  extend ActiveSupport::Concern

  included do
    attr_accessor :current_user
    cattr_accessor  :key_init_situation, :condition_init_situation

    belongs_to :situation, required: false
    has_many :situations, -> { order('created_at asc') }, as: :origin

    validates_presence_of :name

    after_create :create_initial_situation

    def forwarded?
      situation&.key_situation&.key&.to_sym == :forwarded
    end

    def deferred?
      situation&.key_situation&.key&.to_sym == :deferred
    end

    def archived?
      situation&.key_situation&.key&.to_sym == :archived
    end

    def draft?
      situation&.key_situation&.key&.to_sym == :draft
    end

    def deferred?
      situation&.key_situation&.key&.to_sym == :deferred
    end

    private

    def create_initial_situation
      return unless key_init_situation?

      self.situations.create(person: current_user.person,
                             key_situation: KeySituation.find_by(key: key_init_situation))

      set_current_situation
    end

    def set_current_situation
      self.situations.reload
      self.update_column(:situation_id, last_situation&.id)
    end

    def last_situation
      situations&.last
    end

    def key_init_situation?
      self.key_init_situation.present? && (!self.condition_init_situation.present? || condition_init_situation.call(self))
    end

    private :key_init_situation, :condition_init_situation
  end

  module ClassMethods
    private

    def initial_situation(initial_situation, condition = true)
      self.condition_init_situation = condition
      self.key_init_situation = initial_situation
    end
  end
end
