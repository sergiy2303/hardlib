class PartsController < ChaptersController
  before_action :authenticate_user!
  before_action :find_chapter
  expose(:part, attributes: :part_params)
  expose(:parts) { find_chapter.parts }

  def create
    if part.save
      redirect_via_turbolinks_to project_chapter_parts_path
    end
  end

  def update
    if part.save
      redirect_via_turbolinks_to project_chapter_parts_path
    else
      render :edit
    end
  end

  def destroy
    part.destroy
    redirect_via_turbolinks_to project_chapter_parts_path
  end

  private

  def part_params
    params.require(:part).permit(:title, :body)
  end

  def find_chapter
    @chapter ||= find_project.chapters.find(params[:chapter_id]) if params[:chapter_id]
  end
end
