class Public::ListsController < ApplicationController

  def new
    @list = List.new
  end
  
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    @list.save
    redirect_to lists_path
  end
  
  def index
    @lists = List.page(params[:page]).per(8)
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    if @list.save
      flash[:notice] = "変更内容が保存されました。"
      redirect_to '/lists'
    else
      @lists = List.all
      render :edit
    end
  end
  
  def destroy
    list = List.find(params[:id])
    if list.destroy
    redirect_to '/lists', notice: "削除されました"
    end
  end

private

  def list_params
    params.require(:list).permit(:name, :image, :introduction, :habitat)
  end
  
end
