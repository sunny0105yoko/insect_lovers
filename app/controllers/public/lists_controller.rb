class Public::ListsController < ApplicationController
  before_action :ensure_current_user, {only: [:edit, :update]}
  def ensure_current_user
    @list = List.find(params[:id])
    if current_user.id != @list.user_id
      redirect_to lists_path
    end
  end
    
  def new
    @list = List.new
  end
  
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    if@list.save
      flash[:notice] = "投稿が成功しました"
    redirect_to lists_path
    else
    render :_new
    end
  end
  
  def index
    @lists = List.page(params[:page]).per(6)
  end

  def show
    @list = List.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    if @list.save
      flash[:notice] = "変更内容が保存されました。"
      redirect_to list_path
    else
      @lists = List.all
      render :edit
    end
  end
  
  def destroy
    list = List.find(params[:id])
    if list.destroy
    redirect_to user_path(list.user_id), notice: "削除されました"
    end
  end

private

  def list_params
    params.require(:list).permit(:name, :image, :introduction, :habitat, :latitude, :longitude)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    @user.email == "guest@example.com"

  end
  
end
