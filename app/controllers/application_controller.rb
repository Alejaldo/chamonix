class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  rescue_from Pundit::NotAuthorizedError, with: :user_non_authorized

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation, :current_password])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def current_user_can_edit?(model)
    user_signed_in? && (model.user == current_user || (model.try(:event).present? && model.event.user == current_user))
  end

  private

  def user_non_authorized
    flash[:alert] = t('pundit.non_authorized')
    redirect_to(request.referrer || root_path)
  end

  def pundit_user
    UserContext.new(current_user, cookies)
  end
end
