class Shared::PartsController < Shared::ChaptersController
  before_action :authenticate_user!
  expose(:part)
  expose(:parts) { find_chapter.parts }

  private

  def find_chapter
    @chapter ||= find_project.chapters.find(params[:chapter_id]) if params[:chapter_id]
  end
end
