class TutorialsController < ApplicationController
  before_action :authenticate_user!
  before_action :note_present?, only: [:post,:posted_note_index,:favitem_index,:posted_index]
  before_action :set_items, only: [:new_favitem,:create_favitem,:favitem_index]

  def post
  end

  def create_note
    note = current_user.notes.build(note_params)
    if note.save
      @own_notes = current_user.notes.includes(comments: :user)
      render 'create.js.erb'
    else
      flash[:danger] = "投稿に失敗しました"
      render 'tutorial/index'
    end
  end

  def favitem_index
  end

  def create_favitem
    item = current_user.favorite_items.build(f_item_params)
    if item.save
        flash[:success] = '登録に成功しました！ページ下部のリンクから次のページへ進みましょう！'
        redirect_to new_favitem_tutorials_path
    else
      flash[:danger] = '登録に失敗しました'
      redirect_to request.referrer || root_url
    end
  end

  def post_favitem
    begin
      params[:item_ids].each do |item_id|
        item = current_user.favorite_items.find_by(id: item_id)
        note = current_user.notes.create!(content: item.name, group_id: params[:group_id])
      end
      flash[:success] = 'これでチュートリアルは終了！ページ下のボタンで移動し、アプリを使いはじめましょう！'
      redirect_to posted_index_tutorials_path

    rescue
      flash[:danger] = "投稿に失敗しました 再度やり直してください"
      redirect_to request.referrer || root_url
    end
  end

  def posted_index
  end

  private
    def note_present?
      if current_user.present?
        @own_notes = current_user.notes.includes(comments: :user)
        @note = current_user.notes.build
      else
        @own_notes = []
      end
    end

    def set_items
      favorite_items = current_user.favorite_items.all
      @favorite_item_groups = current_user.favorite_item_groups
      @item_exists = favorite_items.present?
    end

    def note_params
      params.permit(:content,:image)
    end

    def f_item_params
      params.permit(:name)
    end
end
