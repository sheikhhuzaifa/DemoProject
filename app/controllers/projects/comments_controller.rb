# frozen_string_literal: true

class Projects::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    begin
      @commentable = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      render plain: "Project not found", status: :not_found
    end
  end
end
