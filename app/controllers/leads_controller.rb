# frozen_string_literal: true

class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy]

  def index
    @leads = Lead.all

    if params[:query].present?
      @leads = Lead.where(id: search_leads_ids)
    end
    per_page = params[:leads_per_page] || 20
    @leads = @leads.page(params[:page]).per(per_page)
  end

  def search_leads_ids
    @leads = Lead.where(id: LeadsIndex.query(
      query_string: {
        fields: %i[project_name client_email client_name client_contact],
        query: params[:query], default_operator: "and"
      }
    ).load.map(&:id))
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @lead = Lead.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @lead = Lead.new(lead_params.merge(bd_id: current_user.id))
    authorize @lead

    if @lead.save
      redirect_to @lead
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @lead = Lead.find(params[:id])
    authorize @lead

    if lead_params[:sale].present?
      if @lead.update(lead_params)
        @project = Project.new(project_name: @lead.project_name, assigned_manager_id: 1, lead_id: @lead.id)
        @project.save

        redirect_to @lead, notice: "Lead details updated successfully."
      else
        redirect_to @lead, alert: "Lead details not updated"
      end
    elsif @lead.update(lead_params.except(:sale))
      redirect_to @lead, notice: "Lead details updated successfully."
    else
      redirect_to @lead, alert: "Lead details not updated"
    end
  end

  def destroy
    @lead = Lead.find(params[:id])
    authorize @lead
    @lead.destroy
    redirect_to leads_path
  end

  private

  def set_lead
    begin
      @lead = Lead.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "Lead not found."
      redirect_to leads_path
    end
  end

  def lead_params
    params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact,
                                 :platform_used, :test_type, :bd_id, :sale, :sale_date)
  end

  def search_params
    params.permit(:query)
  end
end
