# frozen_string_literal: true

class PhasesController < ApplicationController
  before_action :set_lead
  before_action :set_phase, only: %i[show edit update]

  def index
    @phases = @lead.phases

    if params[:query].present?
      @phases = @lead.phases.where(id: PhasesIndex.query(
        query_string: {
          fields: %w[phase_type completed],
          query: params[:query], default_operator: "AND"
        }
      ).load.map(&:id))
    end

    per_page = (params[:phases_per_page] || 20)
    @phases = @phases.page(params[:page]).per(per_page)
  end

  def new
    @phase = @lead.phases.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @decorated_phase = PhaseDecorator.new(@phase)
  end

  def create
    @phase = @lead.phases.build(phase_params)
    @phase.lead_id = @lead.id
    authorize @phase

    if @phase.save
      PhaseMailer.with(phase: @phase).send_mail.deliver_now
      respond_to do |format|
        format.html { redirect_to lead_phases_path }
        format.js
      end
    else
      redirect_to lead_phases_path, alert: "Phase Detail Not Created"
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @phase.lead_id = @lead.id
    authorize @phase
    if @phase.update(phase_params)

      redirect_to lead_phases_path
    else
      redirect_to lead_phases_path, alert: "Phase Detail Not Updated"
    end
  end

  def destroy
    @phase = Phase.find(params[:id])
    authorize @phase
    @phase.destroy
    redirect_to lead_phases_path
  end

  private

  def set_lead
    begin
      @lead = Lead.find(params[:lead_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Lead not found."
      redirect_to leads_path
    end
  end

  def set_phase
    begin
      @phase = @lead.phases.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Phase not found."
      redirect_to lead_path(@lead)
    end
  end

  def phase_params
    params.require(:phase).permit(:phase_type, :start_date, :due_date, :creation_date, :completed, :completed_date, :assignee_id, :lead_id)
  end
end
