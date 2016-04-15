class SharedController < ChaptersController
  before_action :authenticate_user!
  expose(:projects) { find_shared_projects }
  expose(:parts) { find_shared_parts }

  def destroy
  end

  private

  def find_shared_projects
    @shared_projects ||= current_user.foreign_shares.projects
  end

  def find_shared_parts
    @shared_parts ||= current_user.foreign_shares.parts
  end
end
