class Admin::ListsController < ApplicationController
  def index
    @lists = List.page(params[:page]).per(8)
  end

  def show
  end

  def edit
  end
  
  private

  def list_params
    params.require(:list).permit(:name, :image, :introduction, :habitat, :updated_at )
  end
  
end
