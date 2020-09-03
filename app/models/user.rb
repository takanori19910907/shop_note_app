class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,:validatable

  has_many :notes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_members
  has_many :groups, through: :group_members
  has_many :favorite_items, dependent: :destroy
  has_many :reviews

  mount_uploader :image, ImageUploader

  # お気に入りアイテムを、日本語索引でグルーピングした配列を返す
  # @return [Hash]
  def favorite_item_groups
    a_line = []
    k_line = []
    s_line = []
    t_line = []
    n_line = []
    h_line = []
    m_line = []
    y_line = []
    r_line = []
    w_line = []
    other_line = []

    favorite_items.each do |item|
      i_initial = NKF.nkf("-h1 -w",item.name[0]).tr("A-Z0-9","Ａ-Ｚ０-９")
      case
      when ["あ","い","う","え","お","a","i","u","e","o","A","I","U","E","O"].include?(i_initial)
          a_line << item
      when ["か","き","く","け","こ","が","ぎ","ぐ","げ","ご","c","k","q","C","K","Q"].include?(i_initial)
          k_line << item
      when ["さ","し","す","せ","そ","ざ","じ","ず","ぜ","ぞ","s","z","S","Z"].include?(i_initial)
          s_line << item
      when ["た","ち","つ","て","と","だ","ぢ","づ","で","ど","t","d","T","D"].include?(i_initial)
          t_line << item
      when ["な","に","ぬ","ね","の","n","N"].include?(i_initial)
          n_line << item
      when ["は","ひ","ふ","へ","ほ","ば","び","ぶ","べ","ぼ","h","b","H","B"].include?(i_initial)
          h_line << item
      when ["ま","み","む","め","も","m","M"].include?(i_initial)
          m_line << item
      when ["や","ゆ","よ","y","Y"].include?(i_initial)
          y_line << item
      when ["ら","り","る","れ","ろ","l","r","L","R"].include?(i_initial)
          r_line << item
      when ["わ","を","ん"].include?(i_initial)
          w_line << item
      else
          other_line << item
      end
    end

    [
      { idx: "あ行", items: a_line },
      { idx: "か行", items: k_line },
      { idx: "さ行", items: s_line },
      { idx: "た行", items: t_line },
      { idx: "な行", items: n_line },
      { idx: "は行", items: h_line },
      { idx: "ま行", items: m_line },
      { idx: "や行", items: y_line },
      { idx: "ら行", items: r_line },
      { idx: "わ行", items: w_line },
      { idx: "その他", items: other_line }
    ]
  end

end
