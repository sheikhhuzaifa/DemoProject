# frozen_string_literal: true

# phase model
class PhasesController < ApplicationController
  before_action :set_lead
  before_action :set_phase, only: %i[show edit update]

  def index
    # @phases = @lead.phases

    if params[:query].present?
      phases_search = PhasesIndex.query(
        query_string: {
          fields: [:phase_type],
          query: params[:query],
          default_operator: 'AND'
        }
      ).load

      phase_type = phases_search.map(&:phase_type)
      @phases = @lead.phases.where(phase_type: phase_type)
      per_page = (params[:phases_per_page] || 10).to_i
      @phases = @phases.page(params[:page]).per(per_page)

    else
      per_page = (params[:phases_per_page] || 10).to_i
      @phases = Phase.page(params[:page]).per(per_page)
    end
  end

  def new
    @phase = @lead.phases.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @phase = @lead.phases.new(phase_params)
    @phase.lead_id = @lead.id
    authorize @phase

    if @phase.save
      PhaseMailer.with(phase: @phase).send_mail.deliver_now
      respond_to do |format|
        format.html { redirect_to lead_phases_path }
        format.js
      end
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
    @phase.lead_id = @lead.id
    authorize @phase
    if @phase.update(phase_params)

      redirect_to lead_phases_path
    else
      render :edit
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
    @lead = Lead.find(params[:lead_id])
  end

  def set_phase
    @phase = @lead.phases.find(params[:id])
  end

  def phase_params
    params.require(:phase).permit(:phase_type, :start_date, :due_date, :creation_date, :completed, :completed_date,
                                  :assignee_id, :lead_id)
  end
end
