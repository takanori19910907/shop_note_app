class FavoriteItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :set_items, only: [:index,:new]

  def index
  end

  def new
    @favorite_item = current_user.favorite_items.build
  end

  def create
    item = current_user.favorite_items.build(f_item_params)
    if item.save
      flash[:success] = "お気に入り商品を登録しました"
    else
      flash[:danger] = "登録に失敗しました、再度やり直してください"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    begin
      params[:item_ids].each do |item_id|
        item = current_user.favorite_items.find_by(id: item_id).destroy!
      end
      flash[:success] = "お気に入り商品を削除しました"
      redirect_to request.referrer || new_favorite_item_path

    rescue
      flash[:danger] = "お気に入り商品の削除に失敗しました、再度やり直してください"
      redirect_to request.referrer || new_favorite_item_path
    end
  end

  def post
    params[:item_ids].each do |item_id|
      item = current_user.favorite_items.find_by(id: item_id)
      note = current_user.notes.create(content: item.name, group_id: params[:group_id])
    end
    flash[:success] = "投稿しました"
    if params[:group_id].present?
      redirect_to chatroom_group_path(params[:group_id])
    else
      redirect_to root_url
    end
  end

  private

    def correct_user
      item = FavoriteItem.find(params[:item_ids]).first
      unless item.user_id == current_user.id
        flash[:danger] = "投稿者本人でないため削除出来ませんでした"
        redirect_to request.referrer || root_url
      end
    end

    def set_items
      favorite_items = current_user.favorite_items.all
      @favorite_item_groups = current_user.favorite_item_groups
      @item_exists = favorite_items.present?
    end

    def f_item_params
      params.require(:favorite_item).permit(:name)
    end
end
