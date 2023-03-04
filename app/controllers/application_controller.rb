class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: '画面を閲覧する権限がありません。'
  end

  private

  def not_authenticated
    redirect_to main_app.login_path
  end
end
