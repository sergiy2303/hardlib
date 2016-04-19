class Shared::ChaptersController < Shared::HomeController
  before_action :authenticate_user!
  expose(:chapter) { find_chapter }
  expose(:chapters) { find_project.chapters }

  private

  def find_project
    @project ||= current_user.foreign_shares.projects.find_by(id: params[:project_id])
  end

  def find_chapter
    @chapter ||= find_project.chapters.find_by(id: params[:id])
  end
end
