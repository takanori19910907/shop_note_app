class FavoriteItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :set_items, only: [:index,:new]

  def index
  end

  def new
    @favorite_item = current_user.favorite_items.new
  end

  def creates
    item = current_user.favorite_items.build(f_item_params)
    if item.save
      url = Rails.application.routes.recognize_path(request.referrer)
      if url == { controller: 'home', action: 't_create' }
        flash[:success] = '登録に成功しました！ページ下部のリンクから次のページへ進みましょう！'
        redirect_to tutorial_2_path
      else
        flash[:success] = 'お気に入り商品を登録しました'
        redirect_to request.referrer || favorite_items_path
      end
    else
      flash[:danger] = '登録に失敗しました'
      redirect_to request.referrer || root_url
    end
  end

  def destroy
    params[:item][:id].each do |item_id|
      current_user.favorite_items.find_by(id: item_id).destroy
    end
    flash[:warning] = 'お気に入り商品を削除しました'
    redirect_to request.referrer || new_favorite_item_path
  end

  def post
    params[:item][:id].each do |item_id|
      item = current_user.favorite_items.find_by(id: item_id)
      note = current_user.notes.create(content: item.name, group_id: params[:group_id])
    end
    url = Rails.application.routes.recognize_path(request.referrer)
    if url == { controller: 'home', action: 't_favItem_post' }
      flash[:success] = 'これでチュートリアルは終了！ページ下のボタンで移動し、アプリを使いはじめましょう！'
      redirect_to tutorial_4_path
    else
      flash[:success] = '投稿しました'
      if params[:group_id].present?
        redirect_to chatroom_group_path(params[:group_id])
      else
        redirect_to root_url
      end
    end
  end

  private

    def correct_user
      item = FavoriteItem.find(params[:item][:id]).first
      unless item.user_id == current_user.id
        flash[:danger] = '投稿者本人でないため削除出来ませんでした'
        redirect_to request.referrer || root_url
      end
    end

    def set_items
      favorite_items = current_user.favorite_items.all
      @item_exists = favorite_items.present?
      @favorite_item_groups = current_user.favorite_item_groups
    end

    def f_item_params
      params.require(:favorite_item).permit(:name)
    end
end
