class PhasesController < ApplicationController
  before_action :set_lead
  before_action :set_phase, only: [:show, :edit, :update]
  rescue_from   Pundit::NotAuthorizedError ,with: :handle_not_authorized

  def index
    @phases = @lead.phases.all
  end

  def new
    @phase = @lead.phases.new
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
    @phase.assignee_id = current_user.id
    @phase.lead_id = @lead.id
    authorize @phase
    if @phase.save
      redirect_to lead_phases_path
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
    @phase.assignee_id = current_user.id
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
    params.require(:phase).permit(:phase_type, :start_date, :due_date, :comments, :creation_date, :completed, :completed_date, :assignee_id, :lead_id)
  end
  def handle_not_authorized(exception)
    redirect_to lead_phases_path, alert: "You are not authorized to perform this action."
  end
end
