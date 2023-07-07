class Public::PostCommentsController < ApplicationController
  
  def create
    list = List.find(params[:list_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.list_id = list.id
    comment.save
    redirect_to list_path(list)
  end
  
  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to list_path(params[:list_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
end
