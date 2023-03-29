class GoogleLoginApiController < ApplicationController
  require 'googleauth/id_tokens/verifier'

  protect_from_forgery except: :callback
  before_action :verify_g_csrf_token

  def callback
    if params[:credential].present?
      payload = Google::Auth::IDTokens.verify_oidc(params[:credential],
                                                   aud: ENV.fetch('GOOGLE_CRIENT_ID', nil))
      user = User.find_or_initialize_by(email: payload['email'], login_type: :google, name: payload['name'])

      if user.save
        auto_login(user)
        redirect_to schedules_path, success: t('.success', name: user.name)
      else
        redirect_to new_user_path, error: t('.fail')
      end

    else
      redirect_to new_user_path, error: t('.fail')
    end
  end

  private

  def verify_g_csrf_token
    if cookies['g_csrf_token'].blank? || params[:g_csrf_token].blank? || cookies['g_csrf_token'] != params[:g_csrf_token]
      redirect_to root_path, error: t('defaults.message.not_authorized')
    end
  end
end
