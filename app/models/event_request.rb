class EventRequest < ApplicationRecord
  after_create :create_initial_situation

  belongs_to :event
  belongs_to :person, required: false
  has_one :situation, -> { order('created_at desc').limit(1) }, as: :origin
  has_many :situations, -> { order('created_at asc') }, as: :origin

  accepts_nested_attributes_for :event, allow_destroy: false

  def create_initial_situation
    self.situations.create(person: person,
                           key_situation: KeySituation.find_by(key: :draft))
  end

  def forward
    return if
    self.situations.create(person: person,
                           key_situation: KeySituation.find_by(key: :forwarded))
  end

  def forward?
    situation&.key_situation&.key&.to_sym == :forwarded
  end
end
