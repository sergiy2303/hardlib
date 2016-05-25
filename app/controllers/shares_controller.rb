class SharesController < ChaptersController
  before_action :authenticate_user!
  before_action :find_document, only: :new
  before_action :previous_path, only: :new

  ALLOWED_DOCUMENT_TYPES = %w(Project Chapter Part)

  def new
  end

  def create
    @share = find_document&.shares&.new(user_id: current_user.id, sharee_id: find_sharee&.id)
    if @share&.save
      redirect_via_turbolinks_to session.delete(:return_to)
    elsif !@share
      flash.now[:error] = 'You cant share this document'
      redirect_via_turbolinks_to projects_path
    else
      render :new
    end
  end

  private

  def find_sharee
    @sharee = User.find_by(email: params[:email])
  end

  def find_document
    return unless ALLOWED_DOCUMENT_TYPES.include?(params[:document_type])
    @document = Object.const_get(params[:document_type]).find_by(id: params[:document_id], user_id: current_user.id)
  end

  def previous_path
    session[:return_to] ||= request.referer
  end
end
