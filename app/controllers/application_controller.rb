class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.superuser?
      flash[:alert] = "Unauthorized access"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
  end

end
