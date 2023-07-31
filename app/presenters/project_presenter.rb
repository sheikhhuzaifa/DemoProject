# frozen_string_literal: true

class ProjectPresenter
  def initialize(project)
    @project = project
  end

  def project_name
    @project.project_name
  end
end
