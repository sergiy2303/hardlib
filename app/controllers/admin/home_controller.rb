class Admin::HomeController < Admin::AdminsController
  before_action :authenticate_user!

  def index
  end

end
