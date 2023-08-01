# frozen_string_literal: true

class LeadPresenter
  def initialize(lead)
    @lead = lead
  end

  def project_name
    @lead.project_name
  end

  def client_name
    @lead.client_name
  end

  def client_contact
    @lead.client_contact
  end

  def client_email
    @lead.client_email
  end

  def sale_status
    if @lead.sale
      "Lead Convert into Sale"
    else
      "Not Converted"
    end
  end

  def sale_date
    @lead.sale_date&.to_date
  end

  def completed_status
    if @lead.sale
      "Completed: #{sale_date}"
    else
      "Not Completed"
    end
  end

  def all_phases_completed?
    phases.all?(&:completed)
  end

  def phases
    @lead.phases
  end

  def sale?
    @lead.sale
  end
end
