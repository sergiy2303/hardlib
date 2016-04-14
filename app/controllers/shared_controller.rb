class SharedController < ChaptersController
  before_action :authenticate_user!
  before_action :find_shares
  expose(:share)
  expose(:shares) { find_shares }
  expose(:projects) { find_shared_projects }
  expose(:parts) { find_shared_parts }

  def destroy
  end

  private

  def find_shares
    @shares ||= Share.where(sharee_id: current_user.id).all
  end

  def find_shared_projects
    @shared_projects = find_shares.projects.map(&:document)
  end

  def find_shared_parts
    @shared_parts = find_shares.parts.map(&:document)
  end
end
