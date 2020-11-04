class NotesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.present?
      @own_notes = current_user.notes.includes(comments: :user)
      @note = current_user.notes.build
    else
      @own_notes = []
    end
  end

  def create
    note = current_user.notes.build(note_params)
      note.save
      if params[:note][:group_id].present?
        # binding.pry
        @group_notes = Note.includes(comments: :user).includes(:user).where(group_id: params[:note][:group_id])
      else
        @own_notes = current_user.notes.includes(comments: :user)
      end
    #     url = Rails.application.routes.recognize_path(request.referrer)
    #     if url == {controller: 'home', action: 't_post'}
    #       flash[:success] = '投稿に成功しました！'
    #       redirect_to t_post_path
    #     else
    #       redirect_to request.referrer || root_url
    #     end
    #   else
    #     flash[:danger] = '投稿に失敗しました'
    #     redirect_to request.referrer || root_url
    #   end
    # binding.pry
    # @post = Note.find(params[:post_id]) #①
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
