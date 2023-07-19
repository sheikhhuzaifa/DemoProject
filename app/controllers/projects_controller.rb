class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @leads = Lead.joins(:phases)
                 .group('leads.id')
                 .having('COUNT(phases.id) = SUM(CASE WHEN phases.completed = ? THEN 1 ELSE 0 END)', true)

    @leads.each do |lead|
      next if Project.exists?(lead_id: lead.id)
      @project = Project.new(project_name: lead.project_name, assigned_manager_id: current_user.id, lead_id: lead.id)
      @project.save
    end

    @projects = Project.all
  end



  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_path, notice: 'Project updated successfully.'
    else
      render :edit
    end
  end
  def assign_manager
    @project = Project.find(params[:id])
    authorize @project
    redirect_to root_path, notice: "Assigned Project assigned successfully."
  end


  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:project_name, :assigned_manager_id, :lead_id)
  end
end
