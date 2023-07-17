class PhaseMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.phase_mailer.send_mail.subject
  #
  def send_mail
    @phase = params[:phase]

    mail to: "to@example.org" ,subject: @phase.phase_type
  end
end
