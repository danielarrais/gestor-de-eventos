class User < ApplicationRecord
  has_and_belongs_to_many :profiles

  before_validation :generate_random_password, unless: -> (d) { d.encrypted_password.present? }
  after_create :create_password_instructions, if: -> (d) { d.senha_gerada }

  attr_accessor :senha_gerada
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
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
