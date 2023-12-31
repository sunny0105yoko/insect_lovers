class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @lists = @user.lists.page(params[:page]).per(6)
    favorites = Favorite.where(user_id: current_user.id).pluck(:list_id)
    @favorite_list = List.find(favorites)
    @list = List.new
  end

  def favorites
    @user = User.find(params[:id])
    redirect_to root_path unless current_user.id
    favorites = Favorite.where(user_id: current_user.id).pluck(:list_id)
    @favorite_list = Kaminari.paginate_array(List.find(favorites)).page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to lists_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "変更内容が保存されました。"
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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end
end
