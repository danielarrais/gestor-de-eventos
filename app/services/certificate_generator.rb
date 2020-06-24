require 'liquid'

class CertificateGenerator
  private_class_method :new

  def self.call(participants)
    self.new.send(:generate_full_text, participants)
  end

  private

  def process_participants
    template = {}
    @participants.each do |participant|
      event = participant.event
      certificate_template = event.certificate_template

      template[:url_backgroud] = participant.event.parent_event&.image&.url || certificate_template.image&.url
      template[:certificate_signatures] = certificate_template.certificate_signatures.map { |x| {
          url: x.image.url,
          name: x.name,
          role: x.role,
      } }
      template[:text] = generate_template_text(participant, event, certificate_template)

      @certificates << template
    end
  end

  def generate_template_text(participant, event, certificate_template)
    values = { 'nome_aluno' => participant.full_name,
               'carga_horaria' => participant.workload_s,
               'nome_evento_pai' => event.full_name,
               'nome_evento' => event.name,
               'tipo_participacao' => participant.type_participation.name,
               'data_inicio' => event.start_date.strftime('%d/%m/%Y'),
               'data_encerramento' => event.closing_date.strftime('%d/%m/%Y') }

    Liquid::Template.parse(certificate_template.body).render(values)
  end

  def generate_full_text(participants)
    @participants = participants
    @certificates = []

    process_participants

    @certificates

    # view = ActionController::Base.new
    # view.render_to_string(file: "#{ActionController::Base.view_paths[0]}/participants/_imprimir.html.erb",
    #             layout: false, locals: { certificates: @certificates })
  end
end