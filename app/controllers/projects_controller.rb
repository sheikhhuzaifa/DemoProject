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


    if params[:query].present?
      project_names = ProjectsIndex.query(
        query_string: {
          fields: [:project_name],
          query: params[:query],
          default_operator: 'AND'
        }
      ).load.map(&:project_name)
      manager_ids = User.where('username LIKE ?', "%#{params[:query]}%").pluck(:id)
      @projects = Project.where('project_name IN (?) OR assigned_manager_id IN (?)', project_names, manager_ids)
      per_page = (params[:projects_per_page] || 10).to_i
      @projects = @projects.page(params[:page]).per(per_page)
    else

      @projects = Project.page(params[:page]).per(10)
    end
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
