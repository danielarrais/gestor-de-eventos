# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :name, null: false
      t.string :surname, null: false
      t.string :registration, null: true
      t.string :cpf, null: false
      t.string :email, null: false
      t.string :cellphone, null: true
      t.datetime :date_of_birth, null: false
      t.string :encrypted_password, null: true

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at


      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true

    # Initialize first account:
    User.create! do |u|
      u.email = 'ec6bba3be6-0e67c9@inbox.mailtrap.io'
      u.password = '123456'
      u.name = 'Daniel'
      u.cpf = '064.127.213-80'
      u.surname = 'Arrais'
      u.date_of_birth = Date.today
    end
  end
end
