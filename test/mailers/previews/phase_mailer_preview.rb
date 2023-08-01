# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/phase_mailer
class PhaseMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/phase_mailer/send_mail
  def send_mail
    phase = Phase.first
    PhaseMailer.with(phase:).send_mail
  end
end
