class PagesController < ApplicationController
  def email
    @phases=Phase.all
    email_directory = Rails.root.join('tmp', 'letter_opener')
    email_files = Dir.glob(email_directory.join('**/rich.html'))

    user_emails = email_files.select do |file|
      file_path = URI.parse(file).path
      file_content = File.read(file_path)
      file_content.include?(current_user.email)
    end

    @emails = user_emails.map do |file|
      file_path = URI.parse(file).path
      file_content = File.read(file_path)
      subject = extract_subject_from_email(file_content)
      { subject: subject, content: file_content }
    end
    @filtered_emails = @emails.select do |email_data|
      @phases.any? { |phase| email_data[:subject].to_s.include?(phase.id.to_s) }
    end
  end

  def assigned_phases
    @leads = Lead.all
  end
  def extract_subject_from_email(email_content)
    subject_match = /<title>(.*?)<\/title>/i.match(email_content)
    subject = subject_match[1] if subject_match
    subject
  end
  def accept_phase
    phase = Phase.find(params[:id])
    phase.update(assignee_id: current_user.id)
    redirect_to emails_path
  end

  def decline_phase
    phase = Phase.find(params[:id])
    phase.update(assignee_id: nil)
    redirect_to emails_path
  end

end
