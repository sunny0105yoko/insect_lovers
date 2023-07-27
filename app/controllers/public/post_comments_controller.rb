class Public::PostCommentsController < ApplicationController
  
  def create
    @list = List.find(params[:list_id])
    @comment = PostComment.new(post_comment_params)
    @comment.user_id = current_user.id
    @comment.list_id = @list.id
    #バリデーション
    if @comment.save
      #redirect_to list_path(list)
    else
      render 'lists/ show'
    end
  end
  
  def destroy
    @list = List.find(params[:list_id])
    @comment = PostComment.find(params[:id])
    @comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    @user.email == "guest@example.com"
  end
  
end
