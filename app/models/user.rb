class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :notes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_members
  has_many :groups, through: :group_members
  #グループ新規作成に伴うグループと管理者の関係性を定義
  has_many :own_groups, class_name: 'Group', foreign_key: :admin_user_id
  has_many :favorite_items, dependent: :destroy
  #レビューコメントを残すため nullifyを定義
  has_many :reviews, :dependent => :nullify

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
        if ["あ","い","う","え","お","a","i","u","e","o","A","I","U","E","O"].include?(i_initial)
          a_line << item
        elsif ["か","き","く","け","こ","が","ぎ","ぐ","げ","ご","c","k","q","C","K","Q"].include?(i_initial)
          k_line << item
        elsif ["さ","し","す","せ","そ","ざ","じ","ず","ぜ","ぞ","s","z","S","Z"].include?(i_initial)
          s_line << item
        elsif ["た","ち","つ","て","と","だ","ぢ","づ","で","ど","t","d","T","D"].include?(i_initial)
          t_line << item
        elsif ["な","に","ぬ","ね","の","n","N"].include?(i_initial)
          n_line << item
        elsif ["は","ひ","ふ","へ","ほ","ば","び","ぶ","べ","ぼ","h","b","H","B"].include?(i_initial)
          h_line << item
        elsif ["ま","み","む","め","も","m","M"].include?(i_initial)
          m_line << item
        elsif ["や","ゆ","よ","y","Y"].include?(i_initial)
          y_line << item
        elsif ["ら","り","る","れ","ろ","l","r","L","R"].include?(i_initial)
          r_line << item
        elsif ["わ","を","ん"].include?(i_initial)
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

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

end
