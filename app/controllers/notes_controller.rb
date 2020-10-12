class NotesController < ApplicationController
  before_action :authenticate_user!

  def create
    if params[:content].present? || params[:image].present?                                             #取得した値にcontent、imageが含まれる場合の処理
      params[:content].split(/[[:blank:]]+/).each do |note|                                             #値を分解、再結合し1つずつメモを作成
        current_user.notes.create(content: note, group_id: params[:group_id], image: params[:image])
      end
      if params[:image].present? && params[:content] == ''                                              #imageだけでも投稿出来るようcontentが空且つimageが含まれる処理を条件分岐として定義
        current_user.notes.create(content: '', group_id: params[:group_id], image: params[:image])
      end
      url = Rails.application.routes.recognize_path(request.referrer)                                   #もといたページ情報によって処理を分けるため 変数urlを定義
      if url == {controller: 'home', action: 't_post'}
        flash[:success] = '投稿に成功しました！'
        redirect_to t_post_path
      else
        redirect_to request.referrer || root_url
      end
    else
      flash[:danger] = '投稿に失敗しました'
      redirect_to request.referrer || root_url
    end
  end

  def count
    @count = Note.find(params[:note_id])
    @count.update(count_params)
    if @count.save
      redirect_to request.referrer || root_url
    else
      flash[:danger] = '投稿に失敗しました'
      render 'home/index'

    end
  end

  def destroy
    params[:note_ids].each do |note_id|
      Note.find_by(id: note_id).destroy
    end
    redirect_to request.referrer || root_url
  end

  private

  def count_params
    params.permit(:count)
  end
end
