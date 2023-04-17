class UserSessionsController < ApplicationController
  def new; end

  def login_mail; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to schedules_path, success: t('.success', name: @user.name)
    else
      flash.now[:error] = t('.fail')
      render :login_mail, status: :unprocessable_entity
    end
  end

  def guest_login
    @guest_user = User.create(
      name: 'ゲスト',
      email: "#{SecureRandom.alphanumeric(10)}@email.com",
      role: 1,
      password: 'password',
      password_confirmation: 'password'
    )
    auto_login(@guest_user)
    redirect_to schedules_path, success: t('.success')
  end

  def destroy
    logout
    redirect_to new_user_path, success: t('.success')
  end
end
