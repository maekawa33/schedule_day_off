class UserSessionsController < ApplicationController
  skip_before_action :require_login
  
  def new; end

  def login_mail; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to new_user_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_user_path
  end
end
