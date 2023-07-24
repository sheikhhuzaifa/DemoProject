# frozen_string_literal: true

module Projects
  # projects model
  class CommentsController < CommentsController
    before_action :set_commentable

    private

    def set_commentable
      @commentable = Project.find(params[:project_id])
    end
  end
end
