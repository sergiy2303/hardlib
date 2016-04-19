class Shared::ProjectsController < Shared::HomeController
  before_action :authenticate_user!
  expose(:project) { find_project }
  expose(:projects) { current_user.projects }

  private

  def find_project
    @project ||= current_user.foreign_shares.projects.find_by(id: params[:id])
  end
end
