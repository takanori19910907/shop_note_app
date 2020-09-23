class FavoriteItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]
  before_action :set_items, only: [:index,:new]
  before_action :sort_items, only: [:index,:new]

  def index
  end

  def new
    @favorite_item = current_user.favorite_items.new
  end

  def create
    if params[:favorite_item][:name].present?
      params[:favorite_item][:name].split(/[[:blank:]]+/).each do |item|
        unless FavoriteItem.find_by(name: item, user_id: current_user.id).present?
          current_user.favorite_items.create(name: item)
        end
      end
      url = Rails.application.routes.recognize_path(request.referrer)
      if url == { controller: 'home', action: 'tutorial_create_f_item' }
        flash[:success] = '登録に成功しました！ページ下部のリンクから次のページへ進みましょう！'
        redirect_to tutorial_create_f_item_path
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
      current_user.favorite_items.find_by(id: item_id).delete
    end
    flash[:warning] = 'お気に入り商品を削除しました'
    redirect_to request.referrer || new_favorite_item_path
  end

  def post
    params[:item][:id].each do |item_id|
      item = current_user.favorite_items.find_by(id: item_id)
      note = Note.create(content: item.name, user_id: item.user_id, group_id: params[:group_id])
    end
    if params[:group_id].present?
      flash[:success] = '投稿しました'
      redirect_to chatroom_group_path(params[:group_id])
    else
      url = Rails.application.routes.recognize_path(request.referrer)
      if url == { controller: 'home', action: 'tutorial_index_f_item' }
        flash[:success] = 'これでチュートリアルは終了！ページ下のボタンで移動し、アプリを使いはじめましょう！'
        redirect_to tutorial_note_index_path
      else
        flash[:success] = '投稿しました'
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
      @favorite_items = current_user.favorite_items.all
    end

    def sort_items
      @A_line = []
      @K_line = []
      @S_line = []
      @T_line = []
      @N_line = []
      @H_line = []
      @M_line = []
      @Y_line = []
      @R_line = []
      @W_line = []
      @other_line = []
      @favorite_items.each do |item|
      item_initial = NKF.nkf('-h1 -w', item.name[0]).tr('Ａ-Ｚ０-９','A-Z0-9').downcase

      case item_initial
      when "あ","い","う","え","お","a","i","u","e","o"
        @A_line << item
      when "か","き","く","け","こ","が","ぎ","ぐ","げ","ご","c","k","q"
        @K_line << item
      when "さ","し","す","せ","そ","ざ","じ","ず","ぜ","ぞ","s","z"
        @S_line << item
      when "た","ち","つ","て","と","だ","ぢ","づ","で","ど","t","d"
        @T_line << item
      when "な","に","ぬ","ね","の","n"
        @N_line << item
      when "は","ひ","ふ","へ","ほ","ば","び","ぶ","べ","ぼ","ぱ","ぴ","ぷ","ぺ","ぽ","h","b","p"
        @H_line << item
      when "ま","み","む","め","も","m"
        @M_line << item
      when "や","ゆ","よ","y"
        @Y_line << item
      when "ら","り","る","れ","ろ","r","l"
        @R_line << item
      when "わ","を","ん","w"
        @W_line << item
      else
        @other_line << item
      end
      end
    end
end
