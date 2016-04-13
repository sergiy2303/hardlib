class ChaptersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project
  expose(:chapter, attributes: :chapter_params)
  expose(:chapters) { find_project.chapters }

  def create
    if chapter.save
      redirect_via_turbolinks_to project_chapters_path
    end
  end

  def update
    if chapter.save
      redirect_via_turbolinks_to project_chapters_path
    else
      render :edit
    end
  end

  def destroy
    chapter.destroy
    redirect_via_turbolinks_to project_chapters_path
  end

  private

  def chapter_params
    params.require(:chapter).permit(:title)
  end

  def find_project
    @project ||= current_user.projects.find(params[:project_id]) if params[:project_id]
  end
end
