class NotesController < ApplicationController
  before_action :authenticate_user!, except: :index

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
    if note.save
      @own_notes = current_user.notes.includes(comments: :user)
      render "create.js.erb"
    else
      flash[:danger] = "投稿に失敗しました"
      render "notes/index"
    end
  end

  def count
    @count = Note.find(params[:note_id])
    @count.update(count_params)
    if @count.save
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "投稿に失敗しました"
      render "home/index"
    end
  end

  def destroy
    params[:note_ids].each do |note_id|
      Note.find_by(id: note_id).destroy
    end
    if params[:group_id].present?
      @group_notes = Note.includes(comments: :user).includes(:user).where(group_id: params[:note][:group_id])
    else
      @own_notes = current_user.notes.includes(comments: :user)
    end
    render "destroy.js.erb"
  end

  private

  def note_params
    params.require(:note).permit(:content,:image,:group_id)
  end

  def count_params
    params.permit(:count)
  end
end
