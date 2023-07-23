class Admin::ListsController < ApplicationController
  def index
    @lists = List.page(params[:page]).per(6)
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end
  
  def destroy
    list = List.find(params[:id])
    if list.destroy
    redirect_to admin_lists_path, notice: "削除されました"
    end
  end
  
  private

  def list_params
    params.require(:list).permit(:name, :image, :introduction, :habitat, :updated_at )
  end
  
end
