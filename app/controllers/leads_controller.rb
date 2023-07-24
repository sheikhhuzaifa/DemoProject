# frozen_string_literal: true

class LeadsController < ApplicationController
  before_action :set_lead, only: %i[show edit update destroy]

  def index
    @leads = Lead.page(params[:page]).per(3)

    if params[:query].present?
      @leads_search = LeadsIndex.query(
        wildcard: {
          project_name: {
            value: "*#{params[:query]}*"
          }
        }
      ).load
      project_names = @leads_search.map(&:project_name)

      @clients_email_search = LeadsIndex.query(
        wildcard: {
          client_email: {

            value: "*#{params[:query]}*"
          }
        }
      ).load
      client_email = @clients_email_search.map(&:client_email)
      @clients_name_search = LeadsIndex.query(
        wildcard: {
          client_name: {
            value: "*#{params[:query]}*"
          }
        }
      ).load
      client_name = @clients_name_search.map(&:client_name)
      @sale_search = LeadsIndex.query(
        wildcard: {
          sale: {
            value: "*#{params[:query]}*"
          }
        }
      ).load
      sale = @sale_search.map(&:sale)
      matching_leads = Lead.where('project_name IN (?) OR client_email IN (?) OR client_name IN (?) OR sale IN (?)', project_names,
                                  client_email, client_name, sale)
      @leads_with_details = matching_leads.page(params[:page]).per(3)
    else
      @leads_with_details = nil
    end
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
      if @lead.update(sale: lead_params[:sale])
        @lead.update(sale_date: Date.current)
        redirect_to @lead, notice: 'Sale attribute updated successfully.'
      else
        render :edit
      end
    elsif @lead.update(lead_params.except(:sale))
      redirect_to @lead, notice: 'Lead details updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    authorize @lead
    @lead.destroy ? (redirect_to leads_url, notice: 'Lead was successfully destroyed.') : 'Error'
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:project_name, :client_name, :client_address, :client_email, :client_contact,
                                 :platform_used, :test_type, :bd_id, :sale, :sale_date)
  end

  def search_params
    params.permit(:query)
  end
end
