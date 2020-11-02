class Permission < ApplicationRecord
  has_and_belongs_to_many :profiles

  validates_presence_of :action_key, :controller_key

  serialize :equivalent_actions
end
