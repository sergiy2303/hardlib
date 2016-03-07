class Admin::AdminsController < ApplicationController
  layout 'admin'

  private

  def authenticate_user!
    return if admin?
    redirect_to access_denied_path
  end
end
