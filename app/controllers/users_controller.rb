class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  authorize_resource only: %i[show edit update]
  def show
    @schedules = Schedule.includes(:user, :events)
                         .where(user_id: params[:id])
                         .page(params[:user_page])
                         .per(9)
    @favorite_schedules = Schedule.joins(:favorites).includes(%i[user events])
                                  .where(favorites: { user_id: params[:id] })
                                  .page(params[:favorite_page]).per(9)
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
      auto_login(@user)
      redirect_to schedules_path, success: t('.success', name: @user.name)
    else
      flash.now[:error] = t('.fail')
      render :register_mail, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user), success: t('.success', name: @user.name)
    else
      flash.now[:error] =  t('.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, success: t('.success', name: @user.name)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :role, :password, :password_confirmation)
  end
end
