class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    unless @comment.save
      flash[:danger] = "投稿に失敗しました"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    if @comment.destroy
      flash[:success] = "コメントを削除しました"
    else
      flash[:danger] = "コメントの削除に失敗しました"
    end
    redirect_to request.referrer || root_url
  end

  private

  def correct_user
    @comment = Comment.find(params[:id])
    unless @comment.user_id == current_user.id
      flash[:danger] = "投稿者本人でないため削除出来ませんでした"
      redirect_to request.referrer || root_url
    end
  end

  def comment_params
    params.permit(:content,:note_id)
  end
end
