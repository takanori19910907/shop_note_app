class NotesController < ApplicationController
  before_action :authenticate_user!

  def create
    note = current_user.notes.build(note_params)
if note.save
  url = Rails.application.routes.recognize_path(request.referrer)
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

  def note_params
    params.require(:note).permit(:content,:image,:group_id)
  end

  def count_params
    params.permit(:count)
  end
end
