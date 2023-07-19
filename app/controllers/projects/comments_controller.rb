class Projects::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Lead.find(params[:project_id])
  end
end
