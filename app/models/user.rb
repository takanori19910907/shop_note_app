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

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

end
