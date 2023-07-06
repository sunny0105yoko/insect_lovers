class Public::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to current_user_users_path
    else
      render 'edit'
    end
  end
end
