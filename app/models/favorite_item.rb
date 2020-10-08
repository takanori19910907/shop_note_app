require 'nkf'

class FavoriteItem < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true
  validates :name, presence: true

  def listup
    self.each do |item|
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
end
