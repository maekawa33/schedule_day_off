class UserSessionsController < ApplicationController

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

  def guest_login
    @guest_user = User.create(
    name: 'ゲスト',
    email: SecureRandom.alphanumeric(10) + "@email.com",
    avatar: open("./app/assets/images/default_icon.png"),
    role: 1,
    password: 'password',
    password_confirmation: 'password'
    )
    auto_login(@guest_user)
    redirect_to schedules_path, success: 'ゲストとしてログインしました'
  end

  def destroy
    logout
    redirect_to new_user_path, notice: "ログアウトに成功しました"
  end
end
