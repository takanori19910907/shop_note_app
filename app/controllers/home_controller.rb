class HomeController < ApplicationController
  before_action :note_present?, only: [:index,:t_post,:t_index]
  before_action :set_itemlist, only: [:t_create,:t_favItem_post]
  def index
  end

  def help
  end

  def t_top
  end

  def t_post
  end

  def t_index
  end

  def t_create
    @favorite_item = current_user.favorite_items.new
    @favorite_items = current_user.favorite_items.all
    @favorite_items.each do |item|
      initial = NKF.nkf('-h1 -w', item.name[0]).tr('Ａ-Ｚ０-９','A-Z0-9').downcase
      case initial
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

  def t_favItem_post
    @favorite_items = current_user.favorite_items.all
    @favorite_items.each do |item|
      initial = NKF.nkf('-h1 -w', item.name[0]).tr('Ａ-Ｚ０-９','A-Z0-9').downcase
      case initial
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

  private
    def note_present?
      if current_user.present?
        @own_notes = current_user.notes.includes(comments: :user)
      else
        @own_notes = []
      end
    end

    def set_itemlist
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
    end
end
