namespace :seeder do
  desc "Generates keys for dealing with situations"
  task key_situations: :environment do
    KeySituation.find_or_create_by(key: :draft).update(description: 'Rascunho', description_female: 'Rascunho')
    KeySituation.find_or_create_by(key: :forwarded).update(description: 'Enviado', description_female: 'Enviada')
    KeySituation.find_or_create_by(key: :returned_for_correction).update(description: 'Devolvido para correção', description_female: 'Devolvida para correção')
    KeySituation.find_or_create_by(key: :deferred).update(description: 'Aprovado', description_female: 'Aprovada')
    KeySituation.find_or_create_by(key: :released_certificates).update(description: 'Certificados liberados', description_female: 'Certificados liberados')
    KeySituation.find_or_create_by(key: :archived).update(description: 'Arquivado', description_female: 'Arquivada')
    KeySituation.find_or_create_by(key: :unarchived).update(description: 'Desarquivado', description_female: 'Desarquivada')
  end
end
