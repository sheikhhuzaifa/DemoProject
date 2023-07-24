# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'lead_management@noreply.com'
  layout 'mailer'
end
