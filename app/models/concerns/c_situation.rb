  module CSituation
    extend ActiveSupport::Concern

    included do
      attr_accessor :current_user

      after_create :create_initial_situation
      after_create :set_current_situation

      validates_presence_of :name, :role

      belongs_to :situation, required: false
      has_many :situations, -> { order('created_at asc') }, as: :origin

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

      def set_current_situation
        self.situations.reload
        self.update_column(:situation_id, last_situation&.id)
      end

      def last_situation
        self.situations&.last
      end
    end

    class_methods do

    end
  end
