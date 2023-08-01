# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def send_mail(subject, month, new_leads, sales_leads)
    @subject = subject
    @month = month
    @new_leads = new_leads
    @sales_leads = sales_leads
    mail(to: "admin@gmail.com", subject:)
  end
end
