class ChaptersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: [:create, :index, :update]
  before_action :find_chapter, only: [:show]
  expose(:chapter, attributes: :chapter_params)
  expose(:chapters) { find_project.chapters }

  def create
    chapter.user_id = current_user.id
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
    @project ||= current_user.projects.find_by(id: params[:project_id]) || current_user.foreign_shares.projects.find_by(id: params[:project_id])
  end

  def find_chapter
    @chapter ||= find_project.chapters.find_by(id: params[:id])
  end
end
