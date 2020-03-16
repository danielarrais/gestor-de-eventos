class User < ApplicationRecord
  belongs_to :person, required: false
  has_and_belongs_to_many :profiles

  accepts_nested_attributes_for :person, allow_destroy: true

  validates_presence_of :email

  before_validation :duplicate_name
  before_validation :generate_random_password, unless: -> (d) { d.encrypted_password.present? }
  after_create :create_password_instructions, if: -> (d) { d.senha_gerada }

  attr_accessor :senha_gerada
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [:google_oauth2]

  def all_actions
    actions = []

    profiles.each do |profile|
      actions.push(*profile.actions.to_a)
    end

    actions
  end

  private

  # Copia nome da pessoa para o usuário
  def duplicate_name
    self.name = self.person.name
  end

  # Gera senha aleatória caso não haja uma
  def generate_random_password
    self.password = SecureRandom.hex
    self.senha_gerada = true
  end

  def create_password_instructions
    token = self.set_reset_password_token
    send_devise_notification(:create_password_instructions, token, {})
  end
end
