class ProjectsController < ApplicationController
  before_action :authenticate_user!
  expose(:project, attributes: :project_params)
  expose(:projects) { current_user.projects }

  def create
    project.user_id = current_user.id
    if project.save
      redirect_via_turbolinks_to projects_path
    end
  end

  def update
    if project.save
      redirect_via_turbolinks_to projects_path
    else
      render :edit
    end
  end

  def destroy
    project.destroy
    redirect_via_turbolinks_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :public)
  end

  def find_project
    @project ||= current_user.projects.find_by(id: params[:id])
  end
end
