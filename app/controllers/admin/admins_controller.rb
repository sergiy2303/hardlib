class Admin::AdminsController < ApplicationController
  layout 'admin'

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  private

  def admin?
    @admin ||= current_user.admin if user_signed_in?
  end

  def authenticate_user!
    return if admin?
    redirect_to access_denied_path
  end
end
