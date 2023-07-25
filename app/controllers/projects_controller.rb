# frozen_string_literal: true

# project model
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @leads = Lead.where(sale: true)

    @leads.each do |lead|
      next if Project.exists?(lead_id: lead.id)

      @project = Project.new(project_name: lead.project_name, assigned_manager_id: current_user.id, lead_id: lead.id)
      @project.save
    end

    @projects = Project.all
    if params[:query].present?
      @projects = Project.where(id: ProjectsIndex.query(
        query_string: {
          fields: [:project_name],
          query: params[:query],
          default_operator: 'AND'
        }
      ).load.map(&:id)).or(Project.where(assigned_manager_id:
        User.where('username LIKE ?', "%#{params[:query]}%")
        .pluck(:id)))
    end
    per_page = (params[:projects_per_page] || 10)
    @projects = @projects.page(params[:page]).per(per_page)
  end

  def show; end

  def edit; end

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

    if @project.update(assign_manager_params)
      redirect_to root_path, notice: 'Project assigned successfully.'
    else
      render :edit
    end
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:project_name, :assigned_manager_id, :lead_id)
  end

  def assign_manager_params
    params.require(:project).permit(:assigned_manager_id)
  end
end
