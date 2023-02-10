class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  authorize_resource only: [:show, :edit, :update, ]
  def show
    @schedules = @user.schedules.page(params[:user_page]).per(6)
    favorites = Favorite.where(user_id: @user.id).pluck(:schedule_id)
    @favorite_schedules = Kaminari.paginate_array(Schedule.find(favorites)).page(params[:favorite_page]).per(6)
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
      redirect_to login_path, notice: "ユーザー「#{@user.name}」を作成しました"
    else
      flash.now[:alert] = "ユーザーの作成に失敗しました"
      render :register_mail, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), notice: "ユーザー「#{@user.name}」を更新しました"
    else
      flash.now[:alert] = "ユーザーの更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: "ユーザー「#{@user.name}」を削除しました"
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :role, :password, :password_confirmation)
  end
end
