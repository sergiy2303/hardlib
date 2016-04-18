class Shared::HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :find_part, only: :part
  expose(:projects) { find_shared_projects }
  expose(:parts) { find_shared_parts }

  private

  def find_shared_projects
    @shared_projects ||= current_user.foreign_shares.projects
  end

  def find_shared_parts
    @shared_parts ||= current_user.foreign_shares.parts
  end

  def find_part
    find_shared_parts.find_by(id: params[:id])
  end
end
