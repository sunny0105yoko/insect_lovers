class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @lists = @user.lists.page(params[:page]).per(6)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end

end
