class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'

  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token

  def callback
    if params[:credential].present?
      payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: '541792608588-bamjotn42uuclaes1os2seja095hked6.apps.googleusercontent.com')
      user = User.find_or_initialize_by(email: payload['email'], login_type: :google, name: payload['name'])

      if user.save
        auto_login(user)
        redirect_to schedules_path, notice:  "#{user.name}でログインに成功しました"
      else
        redirect_to new_user_path, alert: 'ログインに失敗しました'
      end

    else
      redirect_to new_user_path, alert: 'ログインに失敗しました'
    end
  end

  private

  def verify_g_csrf_token
    if cookies["g_csrf_token"].blank? || params[:g_csrf_token].blank? || cookies["g_csrf_token"] != params[:g_csrf_token]
      redirect_to root_path, notice: '不正なアクセスです'
    end
  end
end
