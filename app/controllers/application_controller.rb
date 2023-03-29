class ApplicationController < ActionController::Base
  add_flash_types :success, :error
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to main_app.root_path, error: t('defaults.message.not_authorized')
  end

  private

  def not_authenticated
    redirect_to main_app.login_path, error: t('defaults.message.not_authorized')
  end
end
