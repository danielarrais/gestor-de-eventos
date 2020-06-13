Dir[Rails.root + 'app/controllers/*.rb'].each do |path|
  require path
end

# Busca usuário padrão
user_default = User.find_by_email('ec6bba3be6-0e67c9@inbox.mailtrap.io')

# Cria usuário padrão caso não haja um
user_default = User.create do |u|
  u.name = 'Daniel'
  u.email = 'ec6bba3be6-0e67c9@inbox.mailtrap.io'
  u.password = '123456'

  u.build_person

  u.person.name = 'Daniel'
  u.person.surname = 'Arrais'
  u.person.cpf = '064.127.213-80'
  u.person.date_of_birth = Date.today
end unless user_default.present?

# Importa permissões
Permission::import_from_controllers(ApplicationController.subclasses)

# Busca ou cria perfil admin
admin_profile = Profile.find_or_create_by(name: 'Admin', description: 'Dar acessos a todas as funções do sistema')

# Vincula todas as permissões ao perfil Admin
admin_profile.permissions = Permission.all
admin_profile.users = [user_default]
admin_profile.save