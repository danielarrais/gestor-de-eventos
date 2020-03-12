# Initialize first account:
User.create! do |u|
  u.name = 'Daniel'
  u.email = 'ec6bba3be6-0e67c9@inbox.mailtrap.io'
  u.password = '123456'

  u.build_person

  u.person.name = 'Daniel'
  u.person.surname = 'Arrais'
  u.person.cpf = '064.127.213-80'
  u.person.date_of_birth = Date.today
end