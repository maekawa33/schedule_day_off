class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new register_mail create]
  before_action :set_user, only: %i[show edit update destroy]

  def show
    @schedules = @user.schedules
    favorites = Favorite.where(user_id: @user.id).pluck(:schedule_id)
    @favorite_schedules = Schedule.find(favorites)
  end

  def new
    @user = User.new
  end

  def register_mail
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, success: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation)
  end
end
