class Public::PostCommentsController < ApplicationController

  def create
    @list = List.find(params[:list_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.user_id = current_user.id
    @post_comment.list_id = @list.id
    #バリデーション
    if @post_comment.save
      #redirect_to list_path(list)
    else
      render :validaters
    end
  end

  def destroy
    @list = List.find(params[:list_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
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
