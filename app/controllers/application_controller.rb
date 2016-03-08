class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :first_name << :last_name
    devise_parameter_sanitizer.for(:account_update) << :first_name << :last_name
  end

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  def authenticate_user!(params = {})
    return if user_signed_in?
    redirect_to access_denied_path
  end

  def admin?
    @admin ||= current_user.admin if user_signed_in?
  end

  helper_method :admin?
end
