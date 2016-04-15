class SharesController < ChaptersController
  before_action :authenticate_user!
  before_action :find_document, only: :new

  ALLOWED_DOCUMENT_TYPES = %w(Project Chapter Part)

  def new
  end

  def create
    if find_document.shares.create(user_id: current_user.id, sharee_id: find_sharee.id)
      redirect_via_turbolinks_to projects_path
    end
  end

  private

  def find_sharee
    @sharee = User.find_by(email: params[:email])
  end

  def find_document
    return unless ALLOWED_DOCUMENT_TYPES.include?(params[:document_type])
    @document = Object.const_get(params[:document_type]).find_by(id: params[:document_id])
  end
end
