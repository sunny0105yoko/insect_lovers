class Public::UsersController < ApplicationController
  
  def index
    @users = User.page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
    @lists = @user.lists.all
  end
  
  def favorites
    redirect_to root_path unless current_user.id
    @favorites = Favorite.where(user_id: @user.id).all
  end

  def edit
    @user = User.find(params[:id])

  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    redirect_to user_path(@user.id)
    else
      render 'edit'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def is matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to lists_path
    end
  end
end
