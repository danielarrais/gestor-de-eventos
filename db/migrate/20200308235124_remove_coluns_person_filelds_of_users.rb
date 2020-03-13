class RemoveColunsPersonFileldsOfUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :person_id, :bigint
    add_foreign_key :users, :people

    # Generate person of the exixtents users
    User.all.each do |user|
      user.build_person

      user.person.registration = user.registration
      user.person.cpf = user.cpf
      user.person.name = user.name
      user.person.surname = user.surname
      user.person.cellphone = user.cellphone
      user.person.date_of_birth = user.date_of_birth

      user.save
    end

    # remove coluns
    remove_column :users, :registration
    remove_column :users, :cpf
    remove_column :users, :name
    remove_column :users, :surname
    remove_column :users, :cellphone
    remove_column :users, :date_of_birth
  end
end
