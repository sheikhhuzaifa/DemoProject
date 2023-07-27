# frozen_string_literal: true

class MailAdmin < ApplicationJob
  queue_as :default

  def perform
    last_month_start = Date.today.beginning_of_month
    last_month_end = Date.today.end_of_month
    new_leads = Lead.where(created_at: last_month_start..last_month_end)
    sales_leads = Lead.where(sale: true, updated_at: last_month_start..last_month_end)
    email_subject = "Monthly Lead Report and Sales Update - #{last_month_start.strftime('%B %Y')}"

    UserMailer.send_mail(email_subject, last_month_start.strftime("%B %Y"), new_leads, sales_leads).deliver_now
    puts "Monthly Lead Report Job completed successfully."
  rescue StandardError => e
    puts "Monthly Lead Report Job encountered an error: #{e.message}"
  end
end
