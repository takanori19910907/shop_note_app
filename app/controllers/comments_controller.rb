class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.note_id = params[:note_id]
    if @comment.save
      redirect_to request.referrer || root_url
    else
      flash[:danger] = '投稿に失敗しました'
      redirect_to :back
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:success] = '削除しました'
    redirect_to request.referrer || root_url
  end

  private

  def correct_user
    comment = Comment.find(params[:id])
    unless comment.user_id == current_user.id
      flash[:danger] = '投稿者本人でないため削除出来ませんでした'
      redirect_to request.referrer || root_url
    end
  end

  def comment_params
    params.permit(:content)
  end
end
