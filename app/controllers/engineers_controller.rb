# frozen_string_literal: true

class EngineersController < ApplicationController
  before_action :set_phase
  before_action :set_engineer, only: %i[show edit update destroy]

  def index
    @engineers = @phase.engineers
  end

  def new
    @engineer = @phase.engineers.new
  end

  def create
    @engineer = @phase.engineers.new(engineer_params)
    @engineer.phase_id = @phase.id
    if @engineer.save
      redirect_to phase_engineers_path, notice: "Engineer created successfully."
    else
      render :new
    end
  end

  def show; end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @engineer.update(engineer_params)
      redirect_to phase_engineers_path(@phase), notice: "Engineer updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @engineer.destroy
    redirect_to phase_engineers_path(@phase), notice: "Engineer deleted successfully."
  end

  private

  def set_phase
    @phase = Phase.find(params[:phase_id])
  end

  def set_engineer
    @engineer = @phase.engineers.find(params[:id])
  end

  def engineer_params
    params.require(:engineer).permit(:email, :phase_id)
  end
end
