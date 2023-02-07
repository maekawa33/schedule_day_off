class UserSessionsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def login_mail; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to schedules_path, notice: "#{@user.name}でログインに成功しました"
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :login_mail, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to new_user_path, notice: "ログアウトに成功しました"
  end
end
